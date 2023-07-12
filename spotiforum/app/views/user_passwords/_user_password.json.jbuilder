json.extract! user_password, :id, :password, :salt, :created_at, :updated_at
json.url user_password_url(user_password, format: :json)
