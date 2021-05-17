#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'
require_relative 'lib/ls/command'

DEFAULT_PARAMS = { all_files: false, reverse: false, format: :vertical }.freeze

def main
  opt = OptionParser.new
  params = DEFAULT_PARAMS.dup
  opt.on('-a', 'do not ignore entries starting with .') { params[:all_files] = true }
  opt.on('-l', 'use a long listing format') { params[:format] = :long }
  opt.on('-r', 'reverse order while sorting') { params[:reverse] = true }
  opt.parse(ARGV)

  LS::Command.new(**params).run
end

main
