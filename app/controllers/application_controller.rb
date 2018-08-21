class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def downgrade_premium_user
    user = User.find_by(email: current_user.email)
    user.standard!
    flash[:alert] = "Your account has been downgraded to STANDARD."
    redirect_to(request.referrer || root_path)
  end
end
