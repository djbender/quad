require_relative '../../lib/ascii_table_value_parser'

describe AsciiTableValueParser::CSV do
  DATA_AS_TABLE = <<-TEXT
+-----------+--------------------+--------------+
| name      | dob                | predictable? |
| Malcolm   | September 20, 2468 | false        |
| Zoe       | February 15, 2484  |              |
| Derrial   | null               | true         |
+-----------+--------------------+--------------+

  TEXT

  EXPECTED = [
    ['Malcolm', 'September 20, 2468', false],
    ['Zoe', 'February 15, 2484', nil],
    ['Derrial', nil, true]
  ]

  describe '#each' do
    let(:atv) { AsciiTableValueParser::CSV.new(StringIO.new(DATA_AS_TABLE)) }

    it 'with a block it yields rows of data as CSV rows' do
      i = 0

      atv.each do |row|
        expect(row.fields).to eql EXPECTED[i]
        expect(row[0]).to eql EXPECTED[i][0]
        expect(row['name']).to eql EXPECTED[i][0]
        expect(row[1]).to eql EXPECTED[i][1]
        expect(row['dob']).to eql EXPECTED[i][1]
        expect(row[2]).to eql EXPECTED[i][2]
        expect(row['predictable?']).to eql EXPECTED[i][2]
        i += 1
      end

      expect(i).to eql 3
    end

    it 'without a block it returns an enumerator of data as CSV rows' do
      enum = atv.enum_for
      expect(enum.map(&:fields)).to eql EXPECTED
    end
  end

  describe "#headers" do
    it 'returns all the headers' do
      headers = AsciiTableValueParser::CSV.new(StringIO.new(DATA_AS_TABLE)).headers
      expect(headers).to eql %w|name dob predictable?|
    end
  end
end
