# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require_relative '../lib/command'

class CommandTest < Minitest::Test
  def test_wc
    command = Command.new(['/etc/passwd', '/etc/bashrc'], { show_all: true })
    expected = <<-TEXT
     110     297    6946 /etc/passwd
      10      40     265 /etc/bashrc
     120     337    7211 total
    TEXT
    assert_output expected do
      command.run
    end
  end

  def test_l_option
    command = Command.new(['/etc/passwd'], { show_all: false })
    expected = <<-TEXT
     110 /etc/passwd
    TEXT
    assert_output expected do
      command.run
    end
  end

  def test_stdin
    command = Command.new([], { show_all: true })
    sin = <<~SIN
      apple banana tomato
      coffee sugar
      nattou
    SIN
    $stdin = StringIO.new(sin)
    expected = <<-TEXT
       3       6      40
    TEXT
    assert_output expected do
      command.run
    end
  end

  def test_directory
    command = Command.new(['/tmp'], { show_all: true })
    expected = <<~TEXT
      wc: /tmp: read: Is a directory
    TEXT
    assert_output nil, expected do # stderrのテスト
      command.run
    end
  end
end
