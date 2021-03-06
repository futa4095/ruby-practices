# frozen_string_literal: true

require_relative './file'
require_relative './formatter_factory'

module LS
  class Command
    CURRENT_DIR = '.'

    def initialize(all_files: false, reverse: false, format: :vertical)
      @all_files = all_files
      @reverse = reverse
      @format = format
    end

    def run
      files = collect_files
      sort_files(files)
      print_files(files)
    end

    private

    def collect_files
      if @all_files
        Dir.foreach(CURRENT_DIR).map { |f| LS::File.new(f) }
      else
        Dir.foreach(CURRENT_DIR).reject { |f| f.start_with?('.') }.map { |f| LS::File.new(f) }
      end
    end

    def sort_files(files)
      sort_by_name(files)
      files.reverse! if @reverse
    end

    def sort_by_name(files)
      files.sort_by!(&:name)
    end

    def print_files(files)
      formatter = FormatterFactory.create_formatter(@format, files)
      formatter.output
    end
  end
end
