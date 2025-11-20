class Api::LocationController < ApplicationController
  def provinces
    region_name = params[:region]
    region = Region.joins(:country).find_by(name: region_name, countries: { name: 'Chile' })
    provinces = region ? region.provinces.order(:name).pluck(:name) : []
    render json: provinces
  end

  def communes
    region_name = params[:region]
    province_name = params[:province]
    province = Province.joins(region: :country)
                      .find_by(name: province_name, 
                              regions: { name: region_name }, 
                              countries: { name: 'Chile' })
    communes = province ? province.communes.order(:name).pluck(:name) : []
    render json: communes
  end
end