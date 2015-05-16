require 'rails_helper'

describe RAGStatus do
  describe '.all' do
    subject(:all) { RAGStatus.all }

    example { expect(all.size).to eql(7)}

    describe 'the first item' do
      subject(:status) { all.first }

      example { expect(status.abbr).to eql('G') }
      example { expect(status.color).to eql('Green') }
      example { expect(status.description).to be_nil }
    end
  end

  describe '.[]' do
    subject(:purple) { RAGStatus['P'] }

    example { expect(purple.abbr).to eql('P') }
    example { expect(purple.color).to eql('Purple') }
    example { expect(purple.description).to eql('sieved out') }
  end
end
