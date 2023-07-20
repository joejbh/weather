require 'rails_helper'

RSpec.describe 'create location page,', type: :system do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
    visit new_location_path
  end

  context 'not checked "Add by IP Address",' do
    it 'should not show ip address field' do
      expect(page).to_not have_field("IP Address", type: "text")
    end

    context 'no fields are filled,' do
      it 'should show appropriate errors and not create new Location' do
        click_button 'Create Location'

        expect(page).to_not have_content("Address can't be blank")
        expect(page).to have_content("City can't be blank")
        expect(page).to have_content("State can't be blank")
        expect(page).to have_content("Zip can't be blank")
        expect(page).to have_content("Zip should be in a 5 number format")

        expect(Location.count).to eq(0)
      end
    end

    context 'all fields are filled,' do
      it 'should save the record and show success message' do
        r = make_mock_weather_response("2023-03-2", "44", "77", "nice")

        stub_weather_request(33333, [r])

        fill_in 'Address', with: "123 Street Ave"
        fill_in 'City', with: "Munitown"
        fill_in 'State', with: "OL"
        fill_in 'Zip', with: "33333"

        click_button 'Create Location'
        expect(Location.count).to eq(1)

        expect(page).to have_content("Location was successfully created.")
      end
    end
  end

  context 'checked "Add by IP Address"', type: :system, js: true do
    ip_address = "3.3.3.3"
    ip_r = make_mock_address_response('Munitown', 'OL', '33333')
    r = make_mock_weather_response("2023-03-2", "44", "77", "nice")

    before do
      stub_address_request(ip_address, ip_r)
      stub_weather_request(33333, [r])
      check 'Add by IP Address'
    end

    it 'should remove unnecessary fields and show IP Address' do
      expect(page).to have_field("IP Address", id: "location_ip_address")
      expect(page).to_not have_field('City')
    end

    it 'should require IP Address be filled' do
      click_button 'Create Location'

      # TODO: have error messaging specific to IP Address

      expect(Location.count).to eq(0)
    end

    it 'allow creation via ip address' do
      check 'Add by IP Address'

      expect(page).to have_field("IP Address", id: "location_ip_address")
      expect(page).to_not have_field('City')

      fill_in 'IP Address', with: ip_address
      click_button 'Create Location'

      expect(page).to_not have_field("IP Address", id: "location_ip_address")
      expect(Location.count).to eq(1)
    end
  end
end