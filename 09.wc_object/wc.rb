#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'lib/command'

def main
  Command.new(ARGV, parse_option).run
end

def parse_option
  option = {}
  opt = OptionParser.new
  opt.on('-l', 'The number of lines in each input file is written to the standard output.') { |value| option[:show_number_of_lines] = value }
  opt.parse!(ARGV)
  option[:show_all] = true if option.empty?
  option
end

exit main
