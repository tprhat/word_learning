class WordsController < ApplicationController
  allow_unauthenticated_access
  include GameLogic
  def index
    setup_game(session_prefix: "word")
    @choices = ([ [ @word.definition, "correct" ] ] + @distractors.map { |d| [ d.definition, "wrong" ] }).shuffle
    #   end
  end
end
