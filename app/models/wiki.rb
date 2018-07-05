class Wiki < ApplicationRecord
  belongs_to :user

  validates :title, length: {minimum: 5}, presence:true
  validates :body, length: {minimum: 20}, presence: true
  validates :user, presence: true

  def create_wiki
    Wike.create(title: title, body: body)
  end
end
