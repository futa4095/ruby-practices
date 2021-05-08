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
  end
end
