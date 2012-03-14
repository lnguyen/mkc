require 'spec_helper'

describe "communities/show.html.haml" do
  before(:each) do
    @community = assign(:community, stub_model(Community,
      :name => "Name",
      :region => "Region",
      :code => "Code",
      :race_type => "Race Type",
      :items_type => "Items Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Region/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Code/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Race Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Items Type/)
  end
end
