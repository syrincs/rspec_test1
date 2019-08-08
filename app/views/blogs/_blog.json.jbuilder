json.extract! blog, :id, :name, :description, :created_at, :updated_at
json.url blog_url(blog, format: :json)
