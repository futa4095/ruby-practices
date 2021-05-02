# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def test_game
    game = Game.new
    assert_equal 300, game.scoring('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
  end
end
