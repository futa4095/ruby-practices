# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game'
# require_relative '../lib/frame'

class GameTest < Minitest::Test
  def test_game
    game = Game.new '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    assert_equal 94, game.score
    assert_equal 10, game.frames.count
    assert_equal 9, game.frames.first.score
    assert_equal 15, game.frames.last.score
  end
end
