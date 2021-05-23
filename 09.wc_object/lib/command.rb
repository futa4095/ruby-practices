# frozen_string_literal: true

require_relative 'stdin_counter'
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
      counter = StdinCounter.new
      print_counter(counter)
      return exit_status
    end

    @paths.each do |path|
      counter = WordCounter.new(path)
      if counter.valid?
        print_counter(counter)
        @total.accumlate(counter)
      else
        print_warning(counter)
        exit_status = WARNING
      end
    end
    print_total if @paths.size >= 2
    exit_status
  end

  private

  def print_counter(counter)
    params = { lines: counter.number_of_lines,
               words: counter.number_of_words,
               bytes: counter.number_of_bytes,
               name: counter.name }
    puts format(format_string, params)
  end

  def print_warning(counter)
    warn counter.message
  end

  def print_total
    print_counter @total
  end

  def format_string
    formats = [' %<lines>7s']
    @option[:show_all] && formats << ' %<words>7s' << ' %<bytes>7s'
    formats << ' %<name>s' unless @paths.empty?
    formats.join
  end
end
