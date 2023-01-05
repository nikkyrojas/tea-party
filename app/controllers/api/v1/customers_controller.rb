class Api::V1::CustomersController < ApplicationController
  def show
    customer = Customer.find(params[:id])
    subs = customer.subscriptions
    render json: SubscriptionSerializer.get_subscriptions(subs), status: 200
  end

  def create
    new_customer = Customer.new(customer_params)
    if Customer.find_by(email: params[:email])
      render json: { errors: 'One or all of the following have occured: Email already exist, passwords do not match, or field is missing'}, status: 400 
    elsif new_customer.save
      render json: CustomerSerializer.create_customer(new_customer), status: 201
    else
    render json: { errors: "One or all of the following have occured: Passwords do not match,  Email already exist, or Field is missing"}, status: 400     end
  end

  private 
  def customer_params
    params.permit(:first_name, :last_name, :email, :address, :password, :password_confirmation)
  end
end
