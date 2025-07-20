<?php

namespace App\Http\Controllers\Api\V1;

use App\Enums\SeamlessWalletCode;
use App\Http\Controllers\Controller;
use App\Models\GameList;
use App\Models\User;
use App\Services\ApiResponseService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str; // Make sure to use Http facade for making requests


class DirectLaunchGameController extends Controller
{
    private const LANGUAGE_CODE = 0; // Keeping as 0 as per your provided code

    private const PLATFORM_WEB = 'WEB';

    private const PLATFORM_DESKTOP = 'DESKTOP';

    private const PLATFORM_MOBILE = 'MOBILE';

    public function launchGame(Request $request)
    {
        Log::info('Launch Game API Request', ['request' => $request->all()]);

        $user = Auth::user();
        if (! $user) {
            Log::warning('Unauthenticated user attempting game launch.');

            return ApiResponseService::error(
                SeamlessWalletCode::MemberNotExist,
                'Authentication required. Please log in.'
            );
        }

        try {
            $validatedData = $request->validate([
                'game_code' => 'nullable|string',
                'product_code' => 'required|integer',
                'game_type' => 'required|string',
            ]);

            // If game_code is empty or null, set it to empty string as per provider requirement
            if (empty($validatedData['game_code'])) {
                $validatedData['game_code'] = '';
            }

            $currencyMap = [
                1007 => 'MMK2', 1221 => 'MMK2', 1040 => 'MMK2',
                1046 => 'MMK2', 1004 => 'MMK2',
            ];

            $apiCurrency = $currencyMap[$validatedData['product_code']] ?? config('seamless_key.api_currency');
        } catch (\Illuminate\Validation\ValidationException $e) {
            Log::warning('Launch Game API Validation Failed', ['errors' => $e->errors()]);

            return ApiResponseService::error(
                SeamlessWalletCode::InternalServerError,
                'Validation failed',
                $e->errors()
            );
        }

        // Get or generate password
        $gameProviderPassword = $user->getGameProviderPassword();
        if (! $gameProviderPassword) {
            $gameProviderPassword = Str::random(50);
            $user->setGameProviderPassword($gameProviderPassword);
            Log::info('Generated and stored new game provider password for user', ['user_id' => $user->id]);
        }

        $agentCode = config('seamless_key.agent_code');
        $secretKey = config('seamless_key.secret_key');
        $apiUrl = config('seamless_key.api_url').'/api/operators/launch-game';
        $operatorLobbyUrl = 'https://pp29.site';
        $requestTime = now('Asia/Shanghai')->timestamp;

        $generatedSignature = md5($requestTime.$secretKey.'launchgame'.$agentCode);

        $payload = [
            'operator_code' => $agentCode,
            'member_account' => $user->user_name,
            'password' => $gameProviderPassword,
            'nickname' => $request->input('nickname') ?? $user->name,
            'currency' => $apiCurrency,
            'game_code' => $validatedData['game_code'],
            'product_code' => $validatedData['product_code'],
            'game_type' => $validatedData['game_type'],
            'language_code' => self::LANGUAGE_CODE,
            'ip' => $request->ip(),
            'platform' => self::PLATFORM_WEB,
            'sign' => $generatedSignature,
            'request_time' => $requestTime,
            'operator_lobby_url' => $operatorLobbyUrl,
        ];

        Log::info('Sending Launch Game Request to Provider', ['url' => $apiUrl, 'payload' => $payload]);

        try {
            $response = Http::withHeaders([
                'Content-Type' => 'application/json',
                'Accept' => 'application/json',
            ])->post($apiUrl, $payload);

            $responseData = $response->json();

            // If response fails or has error code, log and return error
            if (! $response->successful() || empty($responseData['url']) && empty($responseData['content'])) {
                Log::error('Provider Launch Game Failed', [
                    'status' => $response->status(),
                    'body' => $response->body(),
                    'payload' => $payload,
                ]);

                return response()->json([
                    'code' => $responseData['code'] ?? 500,
                    'message' => $responseData['message'] ?? 'Launch failed',
                ], 500);
            }

            // If MMK2 provider, return `content` if present (e.g., for PGSoft etc.)
            if ($apiCurrency === 'MMK2') {
                return response()->json([
                    'code' => $responseData['code'] ?? SeamlessWalletCode::Success->value,
                    'message' => $responseData['message'] ?? 'Game launched successfully',
                    'url' => $responseData['url'] ?? '',
                    'content' => $responseData['content'] ?? '',
                ]);
            }

            // Otherwise, return just the URL
            return response()->json([
                'code' => 200,
                'message' => 'Game launched successfully',
                'url' => $responseData['url'],
            ]);
        } catch (\Throwable $e) {
            Log::error('Unexpected error during provider API call', [
                'exception' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
                'request_payload' => $payload,
            ]);

            return response()->json([
                'code' => 500,
                'message' => 'Unexpected error: '.$e->getMessage(),
            ], 500);
        }
    }

}
