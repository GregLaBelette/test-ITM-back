Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "localhost:8000"
    resource "*", headers: :any, methods: :get
  end
end

Rails.application.config.hosts << "localhost"