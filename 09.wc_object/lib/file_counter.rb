# frozen_string_literal: true

require_relative 'base_counter'

class FileCounter < BaseCounter
  attr_reader :name, :message

  def initialize(path = '')
    super()
    @name = path
    validate
    valid? && File.open(@name) { |f| count(f) }
  end

  def valid?
    @message.nil? || @message.empty?
  end

  private

  def validate
    unless File.exist?(@name)
      @message = "wc: #{@name}: open: No such file or directory"
      return
    end

    unless File.file?(@name)
      @message = "wc: #{@name}: read: Is a directory"
      return
    end
    @message = ''
  end
end