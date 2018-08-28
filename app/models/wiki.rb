class Wiki < ApplicationRecord
  belongs_to :user

  def self.standard_scope(user)
    Wiki.where(["user_id = ? and private = ? or private = ?", user.id, true, false]).order(updated_at: :desc)
  end

  def self.admin_scope
    Wiki.all.order(updated_at: :desc)
  end

  has_many :collaborations
  has_many :users, through: :collaborations

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

end
