Rails.application.routes.draw do
  get '/ping' => proc { |env| [200, {}, ['pong']] }
end
