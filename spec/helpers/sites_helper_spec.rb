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

    context '"All" links' do
      let(:current_scopes) { { with_scores: '1', something: 'else' } }

      let(:text)    { 'All' }
      let(:name)    { :with_scores }
      let(:value)   { :all }
      let(:options) { { glyphs: %w(some-glyph) } }

      it { should_not include('with_scores')}
      it { should_not include('active')}
      it { should     include('something=else')}
      it { should     include('<span class="glyphicon some-glyph')}

      context 'is selected' do
        let(:current_scopes) { {} }

        it { should match(/class=.*active/) }
      end
    end
  end

  describe '#site_sort_link' do
    let(:text) { 'Capacity' }
    let(:name) { :sort_by_capacity }
    let(:current_scopes) {{}}

    before { allow(helper).to receive(:current_scopes).and_return(current_scopes) }

    subject(:markup) { helper.site_sort_link(text, name) }

    it 'is not liberal in what it expects' do
      expect { helper.site_sort_link 'Text', 'string_name', '1' }.to raise_error(
                                                                         ArgumentError,
                                                                         /name must be a symbol/
                                                                       )
    end

    context 'no current_scopes' do
      it 'has no glyphicon' do
        expect(markup).not_to include('glyphicon')
      end

      it 'generates a :desc link' do
        expect(markup).to include('href="/sites?sort_by_capacity=desc')
      end
    end

    context ':sort_by_capacity is already desc' do
      let(:current_scopes) { { sort_by_capacity: 'desc' } }

      it 'displays a desc icon' do
        expect(markup).to include('glyphicon-sort-by-attributes-alt')
      end

      it 'generates an :asc link' do
        expect(markup).to include('href="/sites?sort_by_capacity=asc"')
      end
    end

    context ':sort_by_capacity is already asc' do
      let(:current_scopes) { { sort_by_capacity: 'asc', by_green_status: 'green'} }
      it 'generates an :none link' do
        expect(markup).to match(/glyphicon-sort-by-attributes[" ]/)
      end

      it 'preserves other bits in the href' do
        expect(markup).to include('href="/sites?by_green_status=green')
      end

      it 'does not have "none"' do
        expect(markup).not_to include('sort_by_capacity=none')
      end
    end

    context 'another sort is in place' do
      let(:current_scopes) { { sort_by_custard: 'asc', by_green_status: 'green'} }

      it 'adds our sort' do
        expect(markup).to include('sort_by_capacity')
      end
      it 'removes the other sort' do
        expect(markup).not_to include('custard')
      end
    end
  end
end
