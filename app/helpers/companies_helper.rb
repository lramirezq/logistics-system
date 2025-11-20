module CompaniesHelper
  def countries_for_select
    Country.order(:name).pluck(:name, :name)
  end

  def regions_for_select
    chile = Country.find_by(name: 'Chile')
    return [] unless chile
    chile.regions.order(:name).pluck(:name, :name)
  end

  def provinces_for_region(region_name)
    return [] unless region_name.present?
    
    region = Region.joins(:country).find_by(name: region_name, countries: { name: 'Chile' })
    return [] unless region
    
    region.provinces.order(:name).pluck(:name, :name)
  end

  def communes_for_province(region_name, province_name)
    return [] unless region_name.present? && province_name.present?
    
    province = Province.joins(region: :country)
                      .find_by(name: province_name, 
                              regions: { name: region_name }, 
                              countries: { name: 'Chile' })
    return [] unless province
    
    province.communes.order(:name).pluck(:name, :name)
  end

  def chile_regions_data_for_js
    chile = Country.find_by(name: 'Chile')
    return [] unless chile
    
    chile.regions.includes(provinces: :communes).map do |region|
      {
        region: region.name,
        provincias: region.provinces.map do |province|
          {
            name: province.name,
            comunas: province.communes.map { |commune| { name: commune.name } }
          }
        end
      }
    end
  end
end