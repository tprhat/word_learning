require "securerandom"
module GameLogic
  extend ActiveSupport::Concern

  def setup_game(session_prefix:)
    session["#{session_prefix}_score"] ||= 0
    session["#{session_prefix}_round"] ||= 1

    if params.except(:controller, :action).empty?
      session["#{session_prefix}_score"] = 0
      session["#{session_prefix}_round"] = 1
      session["#{session_prefix}_current_id"] = nil
    end

    if params[:commit] == "Next"
      session["#{session_prefix}_round"] += 1
      session["#{session_prefix}_current_id"] = nil
      @show_answer = false
    elsif params[:answer]
      @show_answer = true
      if params[:answer] == "correct"
        session["#{session_prefix}_score"] += 1
        @result = "Correct!"
      else
        @result = "Incorrect."
      end
      s = find_session_by_cookie
      if defined?(s[:user_id]) && s[:user_id]
        # Initialize game_id if not already set
        session["#{session_prefix}_game_id"] ||= SecureRandom.uuid

        # Save a stat for this round
        Stat.create!(
          user: User.find(s[:user_id]),
          round: session["#{session_prefix}_round"],
          guess_id: (params[:answer] == "correct" ? 1 : 0), # adjust as needed
          correct_id: session["#{session_prefix}_current_id"],
          game_id: session["#{session_prefix}_game_id"],
          current_points: session["#{session_prefix}_score"]
        )
      end
    end

    if session["#{session_prefix}_round"] > 10
      @game_over = true
      @score = session["#{session_prefix}_score"]
      session["#{session_prefix}_score"] = nil
      session["#{session_prefix}_round"] = nil
      session["#{session_prefix}_current_id"] = nil
      session["#{session_prefix}_game_id"] = nil
    else
      @round = session["#{session_prefix}_round"]
      @score = session["#{session_prefix}_score"]
    end
    # pick a new word if not selected for this round, new word only after clicking "next"
    if session["#{session_prefix}_current_id"].nil?
    @word = Word.order("RANDOM()").first
    #       # remove the definition keyword only when the user is guessing
    @word.definition = @word.definition.gsub(/#{Regexp.escape(@word.word)}/i, "____")
    # add word id to the session
    session["#{session_prefix}_current_id"] = @word.id
    # this won't work because sessions can only store simple data, not models
    # session["#{session_prefix}_current_id"] = @word
    else
    @word = Word.find(session["#{session_prefix}_current_id"])
    end
    @distractors = Word.where.not(id: @word.id).order("RANDOM()").limit(2)
    @distractors.each do |distractor|
    distractor.definition =distractor.definition.gsub(/\b#{Regexp.escape(distractor.word)}\b/i, "____")
    end
  end
end
