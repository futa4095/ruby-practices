# frozen_string_literal: true

require_relative './frame'
require_relative './shot'

class Game
  attr_reader :frames

  def initialize(throwing_result)
    marks = throwing_result.split(',')
    @frames = build_frames(marks)
  end

  def build_frames(marks)
    frames = Array.new(9) do
      first_mark = marks.shift
      second_mark = first_mark == 'X' ? nil : marks.shift
      Frame.new first_mark, second_mark
    end
    frames << Frame.new(*marks)
  end

  def score
    frames.sum(&:score)
  end
end
