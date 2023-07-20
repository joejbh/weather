require 'rails_helper'

RSpec.describe "Home page,", type: :system do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  it "has basic items" do
    visit locations_path
    expect(page).to have_content("Locations")
    expect(page).to have_link("Add location")
  end

  it "should have no locations initially" do
    visit locations_path
    expect(page).to_not have_content("°F")
  end

  context "has 1 location", js: true do
    before do
      r = ({ data: [
        { datetime: "2023-03-2", low_temp: "44", high_temp: "77", weather: { description: "nice" } },
      ] }).to_json

      stub_request(:get, "https://api.weatherbit.io/v2.0/forecast/daily?key=&postal_code=78751&units=I").
        to_return(status: 200, body: r, headers: {})

      Location.create!({ city: "Austin", state: "Texas", zip: "78751" })
      visit locations_path
    end

    it 'should display its temperature and not initially show chart' do
      expect(page).to have_content("Austin")
      expect(page).to have_content("Texas")
      expect(page).to have_content("78751")
      expect(page).to have_content("44°F / 77°F")

      expect(page).to_not have_css(make_test_id("chart"))
    end

    it 'should display chart and delete button once location expanded' do
      click_button 'Austin'

      expect(page).to have_css(make_test_id("chart"))
      expect(page).to have_button("Delete")
    end

    it 'should be able to delete' do
      expect(Location.count).to eq(1)
      click_button 'Austin'
      click_button 'Delete'
      expect(page).to have_content("Locations")
      expect(Location.count).to eq(0)
    end
  end
end