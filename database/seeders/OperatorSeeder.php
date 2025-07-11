<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Operator;

class OperatorSeeder extends Seeder
{
    public function run()
    {
        Operator::create([
            'code' => 'a3h1',
            'secret_key' => 'shana3h1', // change to a secure value
            'callback_url' => 'https://luckymillion.pro/api/shan/balance',
            'active' => true,
        ]);

        // You can add more operators here
        Operator::create([
            'code' => 'a3h2',
            'secret_key' => 'shana3h2',
            'callback_url' => 'https://a1yoma.online/api/launch-game',
            'active' => true,
        ]);
    }
}
