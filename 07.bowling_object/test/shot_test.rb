# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/shot'

class ShotTest < Minitest::Test
  def test_shot
    shot = Shot.new '1'
    assert_equal 1, shot.score
  end

  def test_shot_x
    shot = Shot.new 'X'
    assert_equal 10, shot.score
  end
end
