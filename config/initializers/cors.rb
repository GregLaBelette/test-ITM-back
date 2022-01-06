Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:8000'
    resource '*', headers: :any, methods: :get
  end
  allow do
    origins 'itm-test-front.gregoirevallette.com'
    resource '*', headers: :any, methods: :get
  end
end

Rails.application.config.hosts << 'localhost'
Rails.application.config.hosts << 'itm-test-front.gregoirevallette.com'
