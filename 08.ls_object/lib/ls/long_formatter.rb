# frozen_string_literal: true

module LS
  class LongFormatter
    TAB_WIDTH = 8

    def initialize(files)
      @files = files
      tab_count_per_filename = ((longest_filename_length.to_f + 1) / TAB_WIDTH).ceil
      @column_width = tab_count_per_filename * TAB_WIDTH
    end

    def output
      print_total
      column_width = make_column_width
      @files.each do |file|
        print_long_row(file, column_width)
      end
    end

    def print_total
      total_blocks = @files.sum { |file| file.stat.blocks }
      puts "total #{total_blocks}"
    end

    def make_column_width
      column_width = {}
      column_width[:number_of_links] = @files.map { |f| f.number_of_links.to_s.length }.max
      column_width[:owner_name] = @files.map { |f| f.owner_name.length }.max
      column_width[:group_name] = @files.map { |f| f.group_name.length }.max
      column_width[:number_of_bytes] = @files.map { |f| f.number_of_bytes.to_s.length }.max
      column_width
    end

    def print_long_row(file, column_width)
      print "#{file.file_mode}  "
      print "#{file.number_of_links.to_s.rjust(column_width[:number_of_links])} "
      print "#{file.owner_name.ljust(column_width[:owner_name])}  "
      print "#{file.group_name.ljust(column_width[:group_name])}  "
      print "#{file.number_of_bytes.to_s.rjust(column_width[:number_of_bytes])} "
      print "#{file.modification_time} "
      print file.name
      print " -> #{file.link_target}" if file.entry_type == 'l'
      print "\n"
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
