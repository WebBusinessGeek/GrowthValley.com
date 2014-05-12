Rails.application.config.after_initialize do
  Dir[Rails.root + 'lib/**/*.rb'].each do |file|
    require file
  end
end