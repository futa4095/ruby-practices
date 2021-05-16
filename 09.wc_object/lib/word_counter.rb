# frozen_string_literal: true

class WordCounter
  attr_reader :name, :number_of_lines, :number_of_words, :number_of_bytes

  def initialize(io, path = '')
    @name = path
    @number_of_lines = 0
    @number_of_words = 0
    @number_of_bytes = 0
    io.each do |line|
      @number_of_lines += 1 if line.end_with? "\n"
      @number_of_words += line.strip.split.count
      @number_of_bytes += line.bytesize
    end
  end
end
