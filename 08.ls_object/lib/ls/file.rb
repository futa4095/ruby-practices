# frozen_string_literal: true

require 'date'
require 'etc'

module LS
  class File
    attr_reader :name, :stat

    def initialize(name)
      @name = name
      @stat = ::File.lstat(name)
    end

    def link_target
      ::File.readlink(@name)
    end

    def file_mode
      entry_type + permissions
    end

    def entry_type
      { 'file' => '-',
        'directory' => 'd',
        'characterSpecial' => 'c',
        'blockSpecial' => 'b',
        'fifo' => 'p',
        'link' => 'l',
        'socket' => 's' }[@stat.ftype]
    end

    def permissions
      (@stat.mode & 0o777).digits(2).reverse.each_slice(3).map do |bits|
        bits.zip(%w[r w x]).map do |bit, c|
          bit == 1 ? c : '-'
        end.join
      end.join
    end

    def number_of_links
      @stat.nlink
    end

    def owner_name
      Etc.getpwuid(@stat.uid).name
    end

    def group_name
      Etc.getgrgid(@stat.gid).name
    end

    def number_of_bytes
      @stat.size
    end

    def modification_time
      before_half_year = Date.today.prev_month(6).to_time
      after_half_year = Date.today.next_month(6).to_time
      if @stat.mtime.between?(before_half_year, after_half_year)
        @stat.mtime.strftime '%_m %_d %R'
      else
        @stat.mtime.strftime '%_m %_d  %Y'
      end
    end
  end
end
