class Api::V1::SubscriptionsController < ApplicationController
  def index
    subs = Subscription.all
    render json: SubscriptionsSerializer.get_subscriptions(subs), status: 200
  end

  def create
    new_subscription = Subscription.new(subscription_params)
    if new_subscription.save
      render json: SubscriptionSerializer.create_subscription(new_subscription), status: 201
    else
      render json: { errors: "something went wrong, param may be missing"}, status: 400
    end
  end

  def destroy
    sub = Subscription.find_by(id: params[:id])
    sub.destroy
  end

  private 
  def subscription_params
    params.permit(:title, :price, :status, :frequency, :tea_id, :customer_id)
  end
end
