# frozen_string_literal: true

class TotalCounter
  TITLE = 'total'

  attr_reader :number_of_lines, :number_of_words, :number_of_bytes, :message

  def initialize
    @number_of_lines = 0
    @number_of_words = 0
    @number_of_bytes = 0
  end

  def name
    TITLE
  end

  def accumlate(another_counter)
    @number_of_lines += another_counter.number_of_lines
    @number_of_words += another_counter.number_of_words
    @number_of_bytes += another_counter.number_of_bytes
  end

  def valid?
    true
  end
end
