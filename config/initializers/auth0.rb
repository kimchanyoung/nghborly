Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'WuwkvmO3lwnNQO0u7LMQrhYkiKlTjLGW',
    'a6EklrAqRFEnRPJIY_2IJv120DSIjv9bNnipFkrz6HgAls4v03pnm5JNoVzBpGYC',
    'nghborly.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end