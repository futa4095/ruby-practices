# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/ls/command'

module LS
  class CommandTest < Minitest::Test
    def test_defalut_ls
      command = Command.new(all_files: false, reverse: false, format: :vertical)
      expected = <<~"TEXT"
        lib\tls.rb\ttest
      TEXT
      assert_output expected do
        command.run
      end
    end

    def test_all_files
      command = Command.new(all_files: true, reverse: false, format: :vertical)
      expected = <<~"TEXT"
        .\t\t.gitkeep\tls.rb
        ..\t\tlib\t\ttest
      TEXT
      assert_output expected do
        command.run
      end
    end

    def test_reverse
      command = Command.new(all_files: false, reverse: true, format: :vertical)
      expected = <<~"TEXT"
        test\tls.rb\tlib
      TEXT
      assert_output expected do
        command.run
      end
    end

    def test_long_format
      command = Command.new(all_files: false, reverse: false, format: :long)
      expected = <<~"TEXT"
        total 8
        drwxr-xr-x  3 kikuchi  staff   96  5  5 11:13 lib
        -rwxr-xr-x  1 kikuchi  staff  544  5  9 21:52 ls.rb
        drwxr-xr-x  3 kikuchi  staff   96  5  5 11:13 test
      TEXT
      assert_output expected do
        command.run
      end
    end
  end
end
