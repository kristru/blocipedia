class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis

  after_initialize :init

  before_save {self.email = email.downcase if email.present?}

  enum role: [:standard, :premium, :admin]

  validates :username, length: {minimum: 5, maximum:100}, presence: true
  validates :password, presence: true, length: {minimum: 5}, if: -> { encrypted_password.nil? }
  validates :password, length: {minimum: 6}, allow_blank: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum:100}

  def init
      self.role  ||= 0.0  #should set role to standard
    end

end
