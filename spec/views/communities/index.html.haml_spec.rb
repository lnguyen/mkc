require 'spec_helper'

describe "communities/index.html.haml" do
  before(:each) do
    assign(:communities, [
      stub_model(Community,
        :name => "Name",
        :region => "Region",
        :code => "Code",
        :race_type => "Race Type",
        :items_type => "Items Type"
      ),
      stub_model(Community,
        :name => "Name",
        :region => "Region",
        :code => "Code",
        :race_type => "Race Type",
        :items_type => "Items Type"
      )
    ])
  end

  it "renders a list of communities" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Region".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Race Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Items Type".to_s, :count => 2
  end
end
