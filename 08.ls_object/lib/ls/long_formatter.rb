# frozen_string_literal: true

module LS
  class LongFormatter
    def initialize(files)
      @files = files
    end

    def output
      print_total
      column_width = make_column_width
      @files.each do |file|
        puts format_line(file, column_width)
      end
    end

    private

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

    def format_line(file, column_width)
      fields = [
        "#{file.file_mode}  ",
        "#{file.number_of_links.to_s.rjust(column_width[:number_of_links])} ",
        "#{file.owner_name.ljust(column_width[:owner_name])}  ",
        "#{file.group_name.ljust(column_width[:group_name])}  ",
        "#{file.number_of_bytes.to_s.rjust(column_width[:number_of_bytes])} ",
        "#{file.modification_time} ",
        file.name
      ]
      fields << " -> #{file.link_target}" if file.entry_type == 'l'
      fields.join
    end
  end
end
