# frozen_string_literal: true

require_relative './frame'
require_relative './shot'

class Game
  attr_reader :frames

  def initialize(throwing_result)
    marks = throwing_result.split(',')
    build_frames(marks)
  end

  def build_frames(marks)
    @frames = Array.new(9) do
      first_mark = marks.shift
      second_mark = first_mark == 'X' ? nil : marks.shift
      Frame.new first_mark, second_mark
    end
    @frames << Frame.new(*marks)
  end

  def score
    9.times.sum(@frames.last.score) do |i|
      if @frames[i].strike?
        next_frame = @frames[i.next]
        after_shots = [next_frame.first_shot, next_frame.second_shot]
        next_next_frame = @frames[i.next.next]
        after_shots += [next_next_frame.first_shot] if next_next_frame
        @frames[i].score + after_shots.compact.take(2).sum(&:score)
      elsif frames[i].spare?
        @frames[i].score + @frames[i.next].first_shot.score
      else
        @frames[i].score
      end
    end
  end
end
