<?php

namespace Database\Seeders;

use App\Enums\TransactionName;
use App\Enums\TransactionType;
use App\Enums\UserType;
use App\Models\User;
use App\Services\WalletService;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UsersTableSeeder extends Seeder
{
    public function run(): void
    {

        $admin = $this->createUser(UserType::Owner, 'Owner', 'moneyking', '09123456789');
        (new WalletService)->deposit($admin, 502000, TransactionName::CapitalDeposit);

        $master_1 = $this->createUser(UserType::Master, 'Master001', 'M123456', '09123456788', $admin->id);
        (new WalletService)->transfer($admin, $master_1, 20000.0, TransactionName::CreditTransfer);

        $agent_1 = $this->createUser(UserType::Agent, 'Agent001', 'A898737', '09112345674', $master_1->id, 'vH4HueE9');
        (new WalletService)->transfer($master_1, $agent_1, 10000.0, TransactionName::CreditTransfer);

        $player_1 = $this->createUser(UserType::Player, 'Player001', 'P111111', '09111111111', $agent_1->id);
        (new WalletService)->transfer($agent_1, $player_1, 3000.0, TransactionName::CreditTransfer);

        $sub_agent_1 = $this->createUser(UserType::SubAgent, 'Sub Agent001', 'SA111111', '09111111112', $agent_1->id);
        (new WalletService)->transfer($agent_1, $sub_agent_1, 3000.0, TransactionName::CreditTransfer);

        $player_2 = $this->createUser(UserType::Player, 'Player002', 'P222222', '09111111113', $sub_agent_1->id);
        (new WalletService)->transfer($sub_agent_1, $player_2, 3000.0, TransactionName::CreditTransfer);

        // Create SuperAdmin
        $superAdmin = $this->createUser(UserType::SystemWallet, 'SystemWallet', 'systemwallet', '09100000000');
        (new WalletService)->deposit($superAdmin, 5000000 * 10, TransactionName::CapitalDeposit);

    }

    private function createUser(UserType $type, $name, $user_name, $phone, $parent_id = null, $referral_code = null)
    {
        return User::create([
            'name' => $name,
            'user_name' => $user_name,
            'phone' => $phone,
            'password' => Hash::make('gscplus'),
            'agent_id' => $parent_id,
            'status' => 1,
            'referral_code' => $referral_code,
            'is_changed_password' => 1,
            'type' => $type->value,
            'payment_type_id' => 1,
            'account_name' => 'Test',
            'account_number' => '3498787787',
        ]);
    }
}