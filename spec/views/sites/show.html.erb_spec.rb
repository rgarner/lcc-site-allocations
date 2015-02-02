require 'rails_helper'

RSpec.describe "sites/show", :type => :view do
  before(:each) do
    @site = assign(:site, Site.create!(
      :shlaa_ref => "Shlaa Ref",
      :address => "Address",
      :area_ha => 1.5,
      :capacity => 1,
      :io_rag => "Io Rag",
      :settlement_hierarchy => "Settlement Hierarchy",
      :green_brown => "Green Brown",
      :reason => "Reason"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Shlaa Ref/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Io Rag/)
    expect(rendered).to match(/Settlement Hierarchy/)
    expect(rendered).to match(/Green Brown/)
    expect(rendered).to match(/Reason/)
  end
end
