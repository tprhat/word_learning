class DefinitionsController < ApplicationController
  allow_unauthenticated_access
  include GameLogic

  def index
    setup_game(session_prefix: "def")
    @choices = ([ [ @word.word, "correct" ] ] + @distractors.map { |d| [ d.word, "wrong" ] }).shuffle
  end
end
