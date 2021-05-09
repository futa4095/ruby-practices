# frozen_string_literal: true

require_relative './long_formatter'
require_relative './vertical_formatter'

module LS
  class FormatterFactory
    def self.create_formatter(format, files)
      case format
      when :vertical
        VerticalFormatter.new(files)
      when :long
        LongFormatter.new(files)
      end
    end
  end
end
