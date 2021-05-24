# frozen_string_literal: true

require_relative 'base_counter'

class StdinCounter < BaseCounter
  def initialize
    super
    count $stdin
  end

  def name = ''
end
