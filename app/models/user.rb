class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { self.role ||= :standard }

  has_many :wiki

  enum role: [:standard, :premium, :admin]

  def self.getUserByID(user_id)
    User.find(user_id).email
  end

end
