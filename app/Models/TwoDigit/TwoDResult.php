<?php

namespace App\Models\TwoDigit;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;
use App\Models\TwoDigit\Battle;

class TwoDResult extends Model
{
    use HasFactory;
    protected $table = 'two_d_results';

    protected $fillable = [
        'win_number',
        'session',
        'result_date',
        'result_time',
        'battle_id',
    ];

    public function battle()
    {
        return $this->belongsTo(Battle::class);
    }

    public function scopeMorning($query)
    {
        return $query->where('session', 'morning');
    }

    public function scopeEvening($query)
    {
        return $query->where('session', 'evening');
    }

    public function scopeToday($query)
    {
        return $query->where('result_date', Carbon::today());
    }





    
}
