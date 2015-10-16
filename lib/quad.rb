require 'quad/version'
require 'csv'

module Quad
  # :nodoc:
  class CSV
    include Enumerable

    SUBSTITUTIONS = {
      'true' => true,
      'false' => false,
      'null' => nil,
      '' => nil
    }.freeze

    attr_reader :headers, :rows

    def initialize(io)
      @io = io
      if io.length > 0
        @io.readline
        @headers = split_table_line(@io.readline.chomp)
      end
    end

    def each
      @io.each_line do |line|
        next if line.chomp.empty?
        next if line =~ /\A\+/
        line.chomp!
        line = split_table_line(line)
        line = substitutions_cleanup(line)
        yield ::CSV::Row.new(@headers, line)
      end
    end

    def self.from_string(string)
      new(StringIO.new(string))
    end

    protected

    def split_table_line(line)
      line[1..-1].split('|').map(&:strip)
    end

    def substitutions_cleanup(line)
      line.map do |token|
        if SUBSTITUTIONS.key?(token)
          SUBSTITUTIONS[token]
        else
          token
        end
      end
    end
  end
end
