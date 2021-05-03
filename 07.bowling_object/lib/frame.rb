# frozen_string_literal: true

require_relative './shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark) unless second_mark.nil?
    @third_shot = Shot.new(third_mark) unless third_mark.nil?
  end

  def score
    [@first_shot, @second_shot, @third_shot].compact.sum(&:score)
  end

  def strike?
    @first_shot.score == 10 && @second_shot.nil?
  end

  def spare?
    @first_shot.score < 10 && score == 10
  end
end
