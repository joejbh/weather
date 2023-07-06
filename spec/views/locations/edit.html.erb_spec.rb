require 'rails_helper'

RSpec.describe "locations/edit", type: :view do
  let(:location) {
    Location.create!(
      address: "MyString",
      city: "MyString",
      state: "MyString",
      zip: "MyString",
      ip_address: "MyString"
    )
  }

  before(:each) do
    assign(:location, location)
  end

  it "renders the edit location form" do
    render

    assert_select "form[action=?][method=?]", location_path(location), "post" do

      assert_select "input[name=?]", "location[address]"

      assert_select "input[name=?]", "location[city]"

      assert_select "input[name=?]", "location[state]"

      assert_select "input[name=?]", "location[zip]"

      assert_select "input[name=?]", "location[ip_address]"
    end
  end
end
