# frozen_string_literal: true

module LS
  class VerticalFormatter
    TAB_WIDTH = 8
    COLUMN_COUNT = 3

    def initialize(files)
      @files = files
      @row_count = (@files.count.to_f / COLUMN_COUNT).ceil
      tab_count_per_filename = ((longest_filename_length.to_f + 1) / TAB_WIDTH).ceil
      @column_width = tab_count_per_filename * TAB_WIDTH
    end

    def output
      rows = @files.group_by { |val| @files.index(val) % @row_count }.values
      rows.each { |fields| puts format_line(fields) }
    end

    private

    def format_line(fields)
      fields[...-1].map{ |field| name_filled_in_tab(field.name) }.join + fields.last.name
    end

    def longest_filename_length
      @files.map { |f| f.name.length }.max
    end

    def name_filled_in_tab(name)
      tab_count = ((@column_width - name.length).to_f / TAB_WIDTH).ceil
      name + "\t" * tab_count
    end
  end
end
