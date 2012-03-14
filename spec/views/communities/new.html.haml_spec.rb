require 'spec_helper'

describe "communities/new.html.haml" do
  before(:each) do
    assign(:community, stub_model(Community,
      :name => "MyString",
      :region => "MyString",
      :code => "MyString",
      :race_type => "MyString",
      :items_type => "MyString"
    ).as_new_record)
  end

  it "renders new community form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => communities_path, :method => "post" do
      assert_select "input#community_name", :name => "community[name]"
      assert_select "input#community_region", :name => "community[region]"
      assert_select "input#community_code", :name => "community[code]"
      assert_select "input#community_race_type", :name => "community[race_type]"
      assert_select "input#community_items_type", :name => "community[items_type]"
    end
  end
end
