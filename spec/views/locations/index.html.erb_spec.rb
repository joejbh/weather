require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        address: "Street Address",
        city: "City",
        state: "State",
        zip: "Zip",
        ip_address: "IP Address"
      ),
      Location.create!(
        address: "Street Address",
        city: "City",
        state: "State",
        zip: "Zip",
        ip_address: "IP Address"
      )
    ])
  end

  it "renders a list of locations" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Street Address".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("City".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("State".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Zip".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("IP Address".to_s), count: 2
  end
end
