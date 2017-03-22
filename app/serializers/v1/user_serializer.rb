class V1::UserSerializer < ApplicationSerializer
  attributes :id, :name, :email, :created_at
  has_many :posts
  link(:self) { v1_user_url(object) }
end