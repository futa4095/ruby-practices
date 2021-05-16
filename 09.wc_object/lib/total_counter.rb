# frozen_string_literal: true

class TotalCounter
  attr_reader :name, :number_of_lines, :number_of_words, :number_of_bytes

  def initialize
    @name = 'total'
    @number_of_lines = 0
    @number_of_words = 0
    @number_of_bytes = 0
  end

  def accumlate(another_counter)
    @number_of_lines += another_counter.number_of_lines
    @number_of_words += another_counter.number_of_words
    @number_of_bytes += another_counter.number_of_bytes
  end
end
