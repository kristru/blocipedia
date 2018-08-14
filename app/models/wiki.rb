class Wiki < ApplicationRecord
  belongs_to :user
    has_many :users 
    validates :title, presence: true
    validates :body, presence: true
end
