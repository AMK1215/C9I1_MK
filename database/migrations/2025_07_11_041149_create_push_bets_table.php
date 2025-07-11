<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('push_bets', function (Blueprint $table) {
            $table->id();

            $table->string('member_account', 64)->index();
            $table->string('currency', 8)->nullable();
            $table->unsignedBigInteger('product_code')->nullable();
            $table->unsignedBigInteger('game_code')->nullable();
            $table->string('game_type', 32)->nullable();

            $table->string('wager_code', 64)->unique();
            $table->string('wager_type', 32)->nullable();
            $table->string('wager_status', 32)->nullable();

            $table->decimal('bet_amount', 20, 2)->nullable();
            $table->decimal('valid_bet_amount', 20, 2)->nullable();
            $table->decimal('prize_amount', 20, 2)->nullable();
            $table->decimal('tip_amount', 20, 2)->nullable();

            $table->timestamp('created_at_provider')->nullable(); // game provider's created_at
            $table->timestamp('settled_at')->nullable();

            $table->json('meta')->nullable();

            $table->timestamps(); // Laravel's created_at and updated_at
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('push_bets');
    }
};
