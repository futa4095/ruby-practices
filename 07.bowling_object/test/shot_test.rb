# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/shot'

class ShotTest < Minitest::Test
  def test_shot
    shot = Shot.new
    assert shot
  end
end
