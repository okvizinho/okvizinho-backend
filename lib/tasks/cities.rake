namespace :populate do

  desc 'Create Cities'
  task cities: :environment do

    cities = [{name: 'Curitiba', uf: 'PR', is_active: true},
      {name: 'São Paulo - Capital', uf: 'SP', is_active: true},
      {name: 'Rio de Janeiro', uf: 'RJ', is_active: true}
    ]

    cities.each do |city|
      City.find_or_create_by!(city)
    end

    puts "cities populated"
  end
end
