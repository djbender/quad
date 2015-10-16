require_relative '../../lib/quad'

RSpec.describe Quad::CSV do
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
    let(:csv) { Quad::CSV.new(StringIO.new(DATA_AS_TABLE)) }

    it 'with a block it yields rows of data as CSV rows' do
      i = 0

      csv.each do |row|
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
      enum = csv.enum_for
      expect(enum.map(&:fields)).to eql EXPECTED
    end
  end

  describe '#headers' do
    it 'returns all the headers' do
      headers = Quad::CSV.new(StringIO.new(DATA_AS_TABLE)).headers
      expect(headers).to eql %w(name dob predictable?)
    end
  end

  describe 'a table with blank fields' do
    let(:input) do
      <<-TEXT
+-----------+--------------------+----------+
| name      | dob                | favorite |
| Zoe       |                    | red      |
+-----------+--------------------+----------+

  TEXT
    end

    let(:expected) do
      [
        ['Zoe', nil, 'red']
      ]
    end

    describe '#each' do
      let(:csv) { Quad::CSV.new(StringIO.new(input)) }

      it 'with a block it yields rows of data as CSV rows' do
        i = 0

        csv.each do |row|
          expect(row.fields).to eql expected[i]
          expect(row[0]).to eql expected[i][0]
          expect(row['name']).to eql expected[i][0]
          expect(row[1]).to eql expected[i][1]
          expect(row['dob']).to eql expected[i][1]
          expect(row[2]).to eql expected[i][2]
          expect(row['favorite']).to eql expected[i][2]
          i += 1
        end

        expect(i).to eql 1
      end
    end
  end

  describe '.from_string' do
    it 'creates an instance from string IO' do
      expect(Quad::CSV.from_string(String.new)).to be_instance_of Quad::CSV
    end
  end
end
