require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        address: "Street Address",
        city: "City",
        state: "State",
        zip: "22222",
        ip_address: "2.2.2.222"
      ),
      Location.create!(
        address: "Street Address",
        city: "City",
        state: "State",
        zip: "22222",
      )
    ])
  end

  it "renders a list of locations" do
    render
    assert_select make_test_id('address_line'), text: Regexp.new("Street Address".to_s), count: 2
    assert_select make_test_id('city_state_zip'), text: "City, State 22222", count: 2
    assert_select make_test_id('ip_address'), text: Regexp.new("2.2.2.222".to_s), count: 1
    assert_select make_test_id('delete'), text: "Delete", count: 2
  end

end
