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
      r = make_mock_weather_response("2023-03-2", 44, 77, "nice", 0.95)
      r2 = make_mock_weather_response("2023-03-3", 44, 77, "nice", 0.90)

      zip = 78751
      stub_weather_request(zip, [r, r2])

      Location.create!({ city: "Austin", state: "Texas", zip: zip })
      visit locations_path
    end

    it 'should display temperature and description, but not initially show chart' do
      expect(page).to have_content("Austin")
      expect(page).to have_content("Texas")
      expect(page).to have_content("78751")
      expect(page).to have_content("44°F / 77°F")

      expect(page).to_not have_content("nice")
      expect(page).to_not have_css(make_test_id("chart"))
    end

    it 'should display chart, details, and delete button once location expanded' do
      click_button 'Austin'

      expect(page).to have_css(make_test_id("chart"))
      expect(page).to have_button("Delete")
      expect(page).to have_content("Chance of Rain: 95%")
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