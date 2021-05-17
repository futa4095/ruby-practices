# frozen_string_literal: true

module LS
  class LongFormatter
    def initialize(files)
      @files = files
    end

    def output
      print_total if @files.count > 1
      column_width = make_column_width
      @files.each do |file|
        puts format_line(file, column_width)
      end
    end

    private

    def print_total
      total_blocks = @files.sum(&:blocks)
      puts "total #{total_blocks}"
    end

    def make_column_width
      %i[nlink owner_name group_name size].each_with_object({}) { |name, column_width| column_width[name] = max_width(name) }
    end

    def max_width(name)
      @files.map do |file|
        column = file.public_send(name)
        column = column.to_s if column.instance_of?(Integer)
        column.length
      end.max
    end

    def format_line(file, column_width)
      fields = [
        "#{file.file_mode}  ",
        "#{file.nlink.to_s.rjust(column_width[:nlink])} ",
        "#{file.owner_name.ljust(column_width[:owner_name])}  ",
        "#{file.group_name.ljust(column_width[:group_name])}  ",
        "#{file.size.to_s.rjust(column_width[:size])} ",
        "#{file.modification_time} ",
        file.name
      ]
      fields << " -> #{file.link_target}" if file.symlink?
      fields.join
    end
  end
end
