# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Admin.create_with({ name: 'Administrador', password: '123456' }).find_or_create_by(email: 'admin@teste.com')


app_params = {
    name: 'React Native App',
    redirect_uri: 'urn:ietf:wg:oauth:2.0:oob'
}
unless Rails.env.production?
  app_params.merge!({ uid: 'fGzcKqfcSq79YIVraSBeph8gfXirqL0ZMDHy31zHZY8',
                      secret: '1G_M8JZNhTAO-BSchgd8oPuQTSIuZIBULxhxSBamK38' })
end

app = Doorkeeper::Application.find_or_create_by(app_params)

puts 'Created DoorkeeperApp:'
puts "Client ID: #{app.uid}"
puts "Client Secret: #{app.secret}"

Rails.logger.debug 'Created DoorkeeperApp:'
Rails.logger.debug "Client ID: #{app.uid}"
Rails.logger.debug "Client Secret: #{app.secret}"

unless City.any?
  Rake::Task['populate:cities'].invoke
end

