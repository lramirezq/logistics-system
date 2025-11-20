# Crear usuario administrador
admin = User.find_or_create_by(email: 'admin@logistics.com') do |user|
  user.password = 'admin123'
  user.password_confirmation = 'admin123'
  user.role = 'admin'
end

puts "Usuario administrador creado: #{admin.email}" if admin.persisted?

# Crear usuario manager
manager = User.find_or_create_by(email: 'manager@logistics.com') do |user|
  user.password = 'manager123'
  user.password_confirmation = 'manager123'
  user.role = 'manager'
end

puts "Usuario manager creado: #{manager.email}" if manager.persisted?

# Cargar países desde CSV
puts "Cargando países..."
require 'csv'
CSV.foreach(Rails.root.join('paises.csv'), headers: true) do |row|
  Country.find_or_create_by(name: row['nombre']) do |country|
    country.iso2 = row['iso2']
    country.iso3 = row['iso3']
    country.phone_code = row['phone_code']
  end
end
puts "Países cargados: #{Country.count}"

# Cargar datos de Chile desde JSON
puts "Cargando regiones, provincias y comunas de Chile..."
chile_data = JSON.parse(File.read(Rails.root.join('provincias.json')))
chile = Country.find_by(name: 'Chile')

if chile
  chile_data.each do |region_data|
    region = chile.regions.find_or_create_by(name: region_data['region'])
    
    region_data['provincias'].each do |province_data|
      province = region.provinces.find_or_create_by(name: province_data['name'])
      
      province_data['comunas'].each do |commune_data|
        province.communes.find_or_create_by(
          name: commune_data['name'],
          code: commune_data['code']
        )
      end
    end
  end
  
  puts "Regiones de Chile: #{chile.regions.count}"
  puts "Provincias de Chile: #{Province.joins(:region).where(regions: { country: chile }).count}"
  puts "Comunas de Chile: #{Commune.joins(province: :region).where(regions: { country: chile }).count}"
end

puts "Seeds completados!"