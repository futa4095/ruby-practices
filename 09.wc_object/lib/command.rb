# frozen_string_literal: true

require_relative 'total_counter'
require_relative 'word_counter'

class Command
  SUCCESS = true
  WARNING = false

  def initialize(paths, option)
    @paths = paths
    @option = option
    @total = TotalCounter.new
  end

  def run
    exit_status = SUCCESS

    if @paths.empty?
      counter = WordCounter.new($stdin)
      print_counter(counter)
      return exit_status
    end

    @paths.each do |path|
      counter = word_count(path)
      if counter
        print_counter(counter)
        @total.accumlate(counter)
      else
        exit_status = WARNING
      end
    end
    print_total if @paths.size >= 2
    exit_status
  end

  def word_count(path)
    unless File.exist?(path)
      warn "wc: #{path}: open: No such file or directory"
      return
    end

    unless File.file?(path)
      warn "wc: #{path}: read: Is a directory"
      return
    end

    File.open(path) { |f| WordCounter.new(f, f.path) }
  end

  def print_counter(counter)
    print_and_format(lines: counter.number_of_lines,
                     words: counter.number_of_words,
                     bytes: counter.number_of_bytes,
                     name: counter.name)
  end

  def print_total
    print_counter @total
  end

  def print_and_format(counter)
    formats = [' %<lines>7s']
    @option[:show_all] && formats << '%<words>7s' << '%<bytes>7s'
    formats << '%<name>s' unless @paths.empty?
    puts format(formats.join(' '), counter)
    # format
  end
end
