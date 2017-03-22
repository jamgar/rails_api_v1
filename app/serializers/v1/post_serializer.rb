class V1::PostSerializer < ApplicationSerializer
  attributes :id, :title, :content, :category, :created_at, :updated_at
  belongs_to :user
end

