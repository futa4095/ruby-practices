# frozen_string_literal: true

class StdinCounter
  include Countable
  attr_accessor :number_of_lines, :number_of_words, :number_of_bytes
  attr_reader :name

  def initialize
    @name = ''
    super
    count $stdin
  end
end
