#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'word_counter'

SUCCESS = true
WARNING = false

def run
  exit_status = SUCCESS
  option = parse_option

  if ARGV.empty?
    counter = WordCounter.new($stdin)
    print_counter(counter, option)
    return exit_status
  end

  ARGV.each do |path|
    counter = word_count(path)
    if counter
      print_counter(counter, option)
    else
      exit_status = WARNING
    end
  end
  print_total(option) if option[:print_total]
  exit_status
end

def parse_option
  option = {}
  opt = OptionParser.new
  opt.on('-l', 'The number of lines in each input file is written to the standard output.') { |value| option[:show_number_of_lines] = value }
  opt.parse!(ARGV)
  option[:show_all] = true if option.empty?
  option[:print_total] = ARGV.size >= 2
  option
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

def print_counter(counter, option)
  print_and_format(option,
                   lines: counter.number_of_lines,
                   words: counter.number_of_words,
                   bytes: counter.number_of_bytes,
                   name: counter.name)
end

def print_total(option)
  print_and_format(option,
                   lines: WordCounter.total_lines,
                   words: WordCounter.total_words,
                   bytes: WordCounter.total_bytes,
                   name: 'total')
end

def print_and_format(option, counter)
  if option[:show_all]
    puts format(' %<lines>7s %<words>7s %<bytes>7s %<name>s', counter)
  else # option[:show_number_of_lines]
    puts format(' %<lines>7s %<name>s', counter)
  end
end

exit(run) if __FILE__ == $PROGRAM_NAME
