class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :goal

  validates :nickname, presence: true, uniqueness: { case_sensitive: true }, length: { maximum: 15 }

end
