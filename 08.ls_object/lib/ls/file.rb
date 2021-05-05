# frozen_string_literal: true

module LS
  class File
    attr_reader :name, :stat

    def initialize(name)
      @name = name
      @stat = ::File.lstat(name)
    end
  end
end
