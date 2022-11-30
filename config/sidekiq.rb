require 'sidekiq/throttled'

Sidekiq.configure_server do |config|
  config.redis = { url: (ENV['REDIS_URL']).to_s, network_timeout: 5 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: (ENV['REDIS_URL']).to_s, network_timeout: 5 }
end

Sidekiq::Throttled.setup!