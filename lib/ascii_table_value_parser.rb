require 'ascii_table_value_parser/version'
require 'csv'

module AsciiTableValueParser
  class CSV
    include Enumerable

    SUBSTITUTIONS = {
      'true' => true,
      'false' => false,
      'null' => nil
    }.freeze

    attr_reader :headers, :rows

    def initialize(io)
      @io = io
      @io.readline
      @headers = split_table_line(@io.readline.chomp)
    end

    def each
      @io.each_line do |line|
        next if line.chomp.empty?
        next if line =~ /\A\+/
        line.chomp!
        line = split_table_line(line)
        line = line.reject(&:empty?)
        line = line.map { |token| SUBSTITUTIONS.has_key?(token) ? SUBSTITUTIONS[token] : token }
        yield ::CSV::Row.new(@headers, line)
      end
    end

    def self.from_string(string)
      self.new(StringIO.new(string))
    end

    protected

    def split_table_line(line)
      line[1..-1].split('|').map(&:strip)
    end

  end
end
