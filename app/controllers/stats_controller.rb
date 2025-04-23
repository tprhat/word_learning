class StatsController < ApplicationController
  def index
    s = find_session_by_cookie
    current_user = User.find(s[:user_id])
    @all_time_stats = current_user.stats.order(created_at: :asc)
    @games = @all_time_stats.group_by(&:game_id)

    sorted_games = @games.sort_by { |game_id, stats| stats.min_by(&:created_at).created_at }
    # create data to show on the line chart
    @chart_data = sorted_games.each_with_index.map do |(_game_id, stats), index|
      [ index + 1, stats.map(&:current_points).max ]
    end

    @per_game_stats = @games.transform_values do |stats|
      {
        total_points: stats.map(&:current_points).max,
        rounds: stats.count
      }
    end
  end
end
