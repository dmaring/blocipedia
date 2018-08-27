class ChargesController < ApplicationController
  def new
  end

  def create
    @amount = 1500

    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: params[:token][:email],
      source: params[:token][:id]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    if charge["status"] == "succeeded"
      flash[:notice] = "Your account has been upgraded to Premium."
      # user = User.find_by(email: current_user.email)
      # user.premium!
      current_user.premium!


    else
      flash[:notice] = charge[:status]
    end


    # flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
     # or wherever

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to root_path
  end

  def destroy
    user = User.find_by(email: current_user.email)
    user.standard!
    flash[:alert] = "Your account has been downgraded to STANDARD."
    redirect_to(request.referrer || root_path)
  end

end
