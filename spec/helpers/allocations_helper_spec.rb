require 'rails_helper'

describe AllocationsHelper do
  describe '#allocation_filter_link' do
    let(:current_scopes) {{}}

    before { allow(helper).to receive(:current_scopes).and_return(current_scopes) }

    subject(:markup) { helper.allocation_filter_link(text, name, value, options) }

    it 'is not liberal in what it expects' do
      expect { helper.allocation_filter_link 'Text', 'string_name', '1' }.to raise_error(
        ArgumentError,
        /name must be a symbol/
      )
    end

    context 'by_policy' do
      let(:text)  { 'Policy' }
      let(:name)  { :by_policy }
      let(:value) { 'HG1' }
      let(:options) { { glyphs: %w(glyphicon-tree-deciduous) } }

      context 'is not selected' do
        let(:current_scopes) { {something: 'else'} }

        it { should be_an(ActiveSupport::SafeBuffer) }
        it { should include ('Policy') }
        it { should include ('<a class="btn') }
        it { should_not include ('<span class="btn') }
        it { should include('<span class="glyphicon glyphicon-tree-deciduous"')}

        it 'is not active' do
          expect(markup).to include('something=else')
          expect(markup).to include('by_policy=HG1')
        end
      end

      context 'is already selected' do
        let(:current_scopes) { {something: 'else', by_policy: 'HG1'} }

        it { should be_an(ActiveSupport::SafeBuffer) }
        it { should_not include ('<a class="btn') }

        it 'is marked active' do
          expect(markup).to include ('<span class="btn')
          expect(markup).to include ('active')
        end

        it { should include('<span class="glyphicon glyphicon-tree-deciduous"') }
      end

      context 'has a class override' do
        let(:options) { { class: 'btn' } }

        it { should include('class="btn"') }
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

  describe 'show_area_ha?' do
    before { allow(helper).to receive(:current_scopes).and_return(current_scopes) }

    subject { helper.show_area_ha? }

    context 'no by_policy filter' do
      let(:current_scopes) { { something: 'else'} }
      it { should be_truthy }
    end

    context 'by_policy filter is not something that has areas' do
      let(:current_scopes) { { something: 'else', by_policy: 'HG1' } }
      it { should be_falsey }
    end

    context 'by_policy filter is something that has areas' do
      let(:current_scopes) { { something: 'else', by_policy: 'HG2' } }
      it { should be_truthy }
    end

  end
end
