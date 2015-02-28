require 'rails_helper'

RSpec.describe "sites/index", :type => :view do
  before(:each) do
    assign(:sites, [
      Site.create!(
        :shlaa_ref => "Shlaa Ref",
        :address => "Address",
        :area_ha => 1.5,
        :capacity => 1,
        :io_rag => "Io Rag",
        :settlement_hierarchy => "Settlement Hierarchy",
        :green_brown => "Green Brown",
        :reason => "Reason"
      ),
      Site.create!(
        :shlaa_ref => "Shlaa Ref 2",
        :address => "Address",
        :area_ha => 1.5,
        :capacity => 1,
        :io_rag => "Io Rag",
        :settlement_hierarchy => "Settlement Hierarchy",
        :green_brown => "Green Brown",
        :reason => "Reason"
      )
    ])
  end

  it "renders a list of sites" do
    render
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Io Rag".to_s, :count => 2
    assert_select "tr>td", :text => "Settlement Hierarchy".to_s, :count => 2
    assert_select "tr>td", :text => "Reason".to_s, :count => 2
  end
end
