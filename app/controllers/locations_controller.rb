require 'net/http'
require 'json'

class LocationsController < ApplicationController
  before_action :set_location, only: %i[ destroy ]

  # GET /locations
  def index
    @locations = Location.all.map do |location|
      location.forecasts = WeatherService.new().get_forecasts_by_zip location.zip

      location
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # POST /locations
  def create
    @location = Location.new(location_params)

    if !@location.ip_address.blank?
      @location = AddressService.new().get_by_ip_address(@location.ip_address)
    end

    respond_to do |format|
      if @location.save
        format.html { redirect_to locations_url, notice: "Location was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url, notice: "Location was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def location_params
    params.require(:location).permit(:address, :city, :state, :zip, :ip_address)
  end
end
