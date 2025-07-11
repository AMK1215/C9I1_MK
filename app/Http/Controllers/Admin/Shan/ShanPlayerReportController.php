<?php

namespace App\Http\Controllers\Admin\Shan;

use App\Http\Controllers\Controller;
use App\Models\Admin\ReportTransaction;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ShanPlayerReportController extends Controller
{
    /**
     * Show the player report for the current user (owner or agent).
     */
    public function index(Request $request)
    {
        $user = Auth::user();
        $reportsQuery = ReportTransaction::query();

        // Date filter (optional)
        if ($request->filled('date_from') && $request->filled('date_to')) {
            $reportsQuery->whereBetween('created_at', [
                $request->input('date_from') . ' 00:00:00',
                $request->input('date_to') . ' 23:59:59'
            ]);
        }

        // Member account filter (optional)
        if ($request->filled('member_account')) {
            $reportsQuery->where('member_account', $request->input('member_account'));
        }

        // OWNER: see all agents' and all players' reports
        if ($user->hasRole('Owner')) {
            // No restriction
        }
        // AGENT: see only his related player reports (all descendant players)
        elseif ($user->hasRole('Agent')) {
            $playerIds = $user->getAllDescendantPlayers()->pluck('id');
            $reportsQuery->whereIn('user_id', $playerIds);
        }
        // PLAYER: see only self
        else {
            $reportsQuery->where('user_id', $user->id);
        }

        // Pagination (10 per page, optional)
        $reports = $reportsQuery->orderByDesc('created_at')->paginate(10);

        return view('admin.shan.report_index', compact('reports'));
    }
}
