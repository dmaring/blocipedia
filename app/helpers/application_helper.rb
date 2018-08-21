module ApplicationHelper
  def premium_user?
    user = User.find_by(email: current_user.email)
    user.premium? || user.admin?
  end
end
