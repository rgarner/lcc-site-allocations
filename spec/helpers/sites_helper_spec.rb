require 'rails_helper'

describe SitesHelper do
  describe '#site_filter_link' do
    let(:current_scopes) {{}}

    before { allow(helper).to receive(:current_scopes).and_return(current_scopes) }

    subject(:markup) { helper.site_filter_link(text, name, value, options) }

    it 'is not liberal in what it expects' do
      expect { helper.site_filter_link 'Text', 'string_name', '1' }.to raise_error(
        ArgumentError,
        /name must be a symbol/
      )
    end

    context 'by_green_status' do
      let(:text)  { 'Greenfield' }
      let(:name)  { :by_green_status }
      let(:value) { 'green' }
      let(:options) { { glyphs: %w(glyphicon-tree-deciduous) } }

      context 'is not selected' do
        let(:current_scopes) { {something: 'else'} }

        it { should be_an(ActiveSupport::SafeBuffer) }
        it { should include ('Greenfield') }
        it { should include ('<a class="btn') }
        it { should_not include ('<span class="btn') }
        it { should include('<span class="glyphicon glyphicon-tree-deciduous"')}
        it { should include('something=else')}
        it { should include('by_green_status=green')}
      end

      context 'is already selected' do
        let(:current_scopes) { {something: 'else', by_green_status: 'green'} }

        it { should be_an(ActiveSupport::SafeBuffer) }
        it { should_not include ('<a class="btn') }
        it { should include ('<span class="btn') }
        it { should include ('active') }
        it { should include('<span class="glyphicon glyphicon-tree-deciduous"')}
      end
    end

    context 'with_scores' do
      let(:text)  { 'With' }
      let(:name)  { :with_scores }
      let(:value) { '1' }
      let(:options) { {} }

      context 'is not selected' do
        let(:current_scopes) { {something: 'else'} }

        it { should include('<a class="btn') }
        it { should include('With') }
        it { should_not include('glyph') }
      end
    end
  end
end
