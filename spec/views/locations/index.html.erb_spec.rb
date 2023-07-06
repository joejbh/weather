require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        address: "Address",
        city: "City",
        state: "State",
        zip: "Zip",
        ip_address: "Ip Address"
      ),
      Location.create!(
        address: "Address",
        city: "City",
        state: "State",
        zip: "Zip",
        ip_address: "Ip Address"
      )
    ])
  end

  it "renders a list of locations" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Address".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("City".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("State".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Zip".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Ip Address".to_s), count: 2
  end
end
