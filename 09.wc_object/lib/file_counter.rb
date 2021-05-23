# frozen_string_literal: true

require_relative 'countable'
class FileCounter
  include Countable
  attr_accessor :number_of_lines, :number_of_words, :number_of_bytes
  attr_reader :name, :message

  def initialize(path = '')
    @name = path
    super()
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
