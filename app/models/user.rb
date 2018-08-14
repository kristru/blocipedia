class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

    has_many :wikis

    before_save { self.role ||= :standard }

    enum role: [:standard, :premium, :admin]

    def downgrade
      self.standard!
      Wiki.all.each do | wiki |
        wiki.update(:private => false) if (wiki.user = self)
      end
    end

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

end
