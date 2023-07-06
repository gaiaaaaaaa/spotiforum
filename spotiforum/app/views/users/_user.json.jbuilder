json.extract! user, :id, :name, :email, :photo, :spotify, :song, :created_at, :updated_at
json.url user_url(user, format: :json)
