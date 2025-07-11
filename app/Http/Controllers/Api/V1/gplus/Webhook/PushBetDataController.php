<?php

namespace App\Http\Controllers\Api\V1\gplus\Webhook;

use App\Enums\SeamlessWalletCode;
use App\Http\Controllers\Controller;
use App\Models\PushBet;
use App\Models\User;
use App\Services\ApiResponseService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Log;

class PushBetDataController extends Controller
{
    /**
     * Handle Push Bet Data from Seamless Wallet API.
     * POST /v1/api/seamless/pushbetdata
     */
    public function pushBetData(Request $request)
{
    Log::info('Push Bet Data API Request', ['request' => $request->all()]);

    // Only validate what's actually sent by the upstream API
    try {
        $request->validate([
            'operator_code' => 'required|string',
            'transactions'  => 'required|array|min:1',
        ]);
    } catch (\Illuminate\Validation\ValidationException $e) {
        Log::warning('Push Bet Data API Validation Failed', ['errors' => $e->errors()]);
        return response()->json([
            'code'    => SeamlessWalletCode::InternalServerError->value,
            'message' => 'Validation failed',
            'before_balance' => 0.0,
            'balance'        => 0.0,
        ]);
    }

    foreach ($request->transactions as $tx) {
        $memberAccount = $tx['member_account'] ?? null;
        $transactionId = $tx['wager_code'] ?? null;

        $user = User::where('user_name', $memberAccount)->first();

        if (! $user) {
            Log::warning('Member not found for pushBetData', ['member_account' => $memberAccount, 'transaction' => $tx]);
            return response()->json([
                'code' => SeamlessWalletCode::MemberNotExist->value,
                'message' => 'Member not found',
            ]);
        }

        // Convert timestamps from seconds to DateTime if needed
        $settledAt         = !empty($tx['settled_at'])         ? now()->setTimestamp((int)$tx['settled_at']) : null;
        $createdAtProvider = !empty($tx['created_at'])         ? now()->setTimestamp((int)$tx['created_at']) : null;

        // Find or create PushBet record
        $pushBet = PushBet::where('transaction_id', $transactionId)->first();
        if ($pushBet) {
            $pushBet->update([
                'member_account'      => $memberAccount,
                'product_code'        => $tx['product_code'] ?? $pushBet->product_code,
                'amount'              => $tx['bet_amount'] ?? $pushBet->amount,
                'action'              => $tx['wager_type'] ?? $pushBet->action,
                'status'              => $tx['wager_status'] ?? $pushBet->status,
                'meta'                => json_encode($tx),
                'wager_status'        => $tx['wager_status'] ?? $pushBet->wager_status,
                'round_id'            => $tx['round_id'] ?? $pushBet->round_id,
                'game_type'           => $tx['game_type'] ?? $pushBet->game_type,
                'channel_code'        => $tx['channel_code'] ?? $pushBet->channel_code,
                'operator_code'       => $request->operator_code,
                'settle_at'           => $settledAt ?? $pushBet->settle_at,
                'created_at_provider' => $createdAtProvider ?? $pushBet->created_at_provider,
                'currency'            => $tx['currency'] ?? $pushBet->currency,
                'game_code'           => $tx['game_code'] ?? $pushBet->game_code,
            ]);
        } else {
            PushBet::create([
                'transaction_id'      => $transactionId,
                'member_account'      => $memberAccount,
                'product_code'        => $tx['product_code'] ?? 0,
                'amount'              => $tx['bet_amount'] ?? 0,
                'action'              => $tx['wager_type'] ?? '',
                'status'              => $tx['wager_status'] ?? '',
                'meta'                => json_encode($tx),
                'wager_status'        => $tx['wager_status'] ?? '',
                'round_id'            => $tx['round_id'] ?? '',
                'game_type'           => $tx['game_type'] ?? '',
                'channel_code'        => $tx['channel_code'] ?? '',
                'operator_code'       => $request->operator_code,
                'settle_at'           => $settledAt,
                'created_at_provider' => $createdAtProvider,
                'currency'            => $tx['currency'] ?? '',
                'game_code'           => $tx['game_code'] ?? '',
            ]);
        }
    }
    
    return response()->json([
        'code' => SeamlessWalletCode::Success->value,
        'message' => '',
    ]);

    // return response()->json([
    //     'code'    => SeamlessWalletCode::Success->value,
    //     'message' => '',
    //     'before_balance' => 0.0,
    //     'balance'        => 0.0,
    // ]);
}

    
}
