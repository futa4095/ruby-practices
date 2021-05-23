# frozen_string_literal: true

module Countable
  def initialize
    self.number_of_lines = 0
    self.number_of_words = 0
    self.number_of_bytes = 0
  end

  private

  def count(io)
    io.each do |line|
      self.number_of_lines += 1 if line.end_with? "\n"
      self.number_of_words += line.strip.split.count
      self.number_of_bytes += line.bytesize
    end
  end
end
