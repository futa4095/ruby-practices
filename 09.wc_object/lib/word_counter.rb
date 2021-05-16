# frozen_string_literal: true

class WordCounter
  attr_reader :name, :number_of_lines, :number_of_words, :number_of_bytes, :message

  def initialize(path = '', use_stdin: false)
    @name = path
    @use_stdin = use_stdin
    @number_of_lines = 0
    @number_of_words = 0
    @number_of_bytes = 0
    validate unless use_stdin
    count if valid?
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

  def count
    io = @use_stdin ? $stdin : File.open(@name)
    io.each do |line|
      @number_of_lines += 1 if line.end_with? "\n"
      @number_of_words += line.strip.split.count
      @number_of_bytes += line.bytesize
    end
    io.close unless @use_stdin
  end
end
