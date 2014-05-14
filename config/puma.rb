# config/puma.rb
threads Integer(ENV['MIN_THREADS']  || 1), Integer(ENV['MAX_THREADS'] || 16)

workers Integer(ENV['PUMA_WORKERS'] || 3)

rackup DefaultRackup
port ENV['PORT'] || 3000
environment ENV['RACK_ENV'] || 'development'
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end

   if defined?(Sidekiq)
    Resque.redis = ENV["REDISTOGO_URL"] || "redis://127.0.0.1:6379"
    Rails.logger.info('Connected to Redis')
  end
end