# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/frame'

class FrameTest < Minitest::Test
  def test_frame
    frame = Frame.new '0', '1'
    assert_equal 1, frame.score
  end

  def test_last_frame
    frame = Frame.new '2', '3', '4'
    assert_equal 9, frame.score
  end

  def test_strike_frame
    frame = Frame.new 'X', nil
    assert_equal 10, frame.score
    assert frame.strike?
  end

  def test_spare_frame
    frame = Frame.new '1', '9'
    refute frame.strike?
    assert frame.spare?
  end
end
