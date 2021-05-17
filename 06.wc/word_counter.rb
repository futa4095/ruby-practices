# frozen_string_literal: true

class WordCounter
  attr_reader :name, :number_of_lines, :number_of_words, :number_of_bytes

  @total_lines = 0
  @total_bytes = 0
  @total_words = 0

  class << self
    attr_accessor :total_lines, :total_bytes, :total_words
  end

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
    WordCounter.total_lines += @number_of_lines
    WordCounter.total_bytes += @number_of_bytes
    WordCounter.total_words += @number_of_words
  end

  def inspect
    super
    puts "name=#{@name} l=#{@number_of_lines} w=#{@number_of_words} b=#{@number_of_bytes}"
  end
end
