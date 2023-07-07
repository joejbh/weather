require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        address: "Street Address",
        city: "City",
        state: "State",
        zip: "11111",
        ip_address: "2.2.2.222"
      ),
      Location.create!(
        address: "Street Address",
        city: "City",
        state: "State",
        zip: "22222",
        ip_address: "2.2.2.222"
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
    assert_select "form>button", text: Regexp.new("Delete".to_s), count: 2
  end
end
