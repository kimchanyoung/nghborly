Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'YOUR_CLIENT_ID',
    'YOUR_CLIENT_SECRET',
    'YOUR_NAMESPACE',
    callback_path: "/auth/auth0/callback"
  )
end