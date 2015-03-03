require 'rails_helper'

describe Site, :type => :model do
  describe '#green_status' do
    let(:site) { Site.new(green_brown: str) }

    subject { site.green_status }

    context 'site is green' do
      let(:str) { 'Greenfield' }
      it { should be :green }
    end
    context 'site is brown' do
      let(:str) { 'Brownfield' }
      it { should be :brown }
    end
    context 'site is mixed' do
      let(:str) { 'Mixed' }
      it { should be :mixed }
    end
    context 'site is neither' do
      let(:str) { 'n/a' }
      it { should be_nil }
    end
    context 'site is unknown' do
      let(:str) { 'flurp' }
      it { should be_nil }
    end
  end
end
