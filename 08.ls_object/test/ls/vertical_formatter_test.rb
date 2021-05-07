# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/ls/file'
require_relative '../../lib/ls/vertical_formatter'

module LS
  class VerticalFormatterTest < Minitest::Test
    TARGET_PATH = '/Users/kikuchi/work/myls/'
    def test_file
      puts TARGET_PATH
      files = %w[1M Gemfile Gemfile.lock a1 file.css file.html file.img file.jpg file1 file2].map { |val| LS::File.new(TARGET_PATH + val) }
      formatter = LS::VerticalFormatter.new(files)
      expected = <<~"TEXT"
        /Users/kikuchi/work/myls/1M\t\t/Users/kikuchi/work/myls/file.css\t/Users/kikuchi/work/myls/file1
        /Users/kikuchi/work/myls/Gemfile\t/Users/kikuchi/work/myls/file.html\t/Users/kikuchi/work/myls/file2
        /Users/kikuchi/work/myls/Gemfile.lock\t/Users/kikuchi/work/myls/file.img
        /Users/kikuchi/work/myls/a1\t\t/Users/kikuchi/work/myls/file.jpg
      TEXT
      assert_output expected do
        formatter.output
      end
    end
  end
end
