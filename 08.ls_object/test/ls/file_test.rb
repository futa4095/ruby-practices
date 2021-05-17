# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/ls/file'

module LS
  class FileTest < Minitest::Test
    def test_file
      file = LS::File.new('ls.rb')
      assert_equal 'ls.rb', file.name
      assert_equal 'file', file.stat.ftype
    end
  end
end
