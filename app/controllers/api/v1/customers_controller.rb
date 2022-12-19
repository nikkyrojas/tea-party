class Api::V1::CustomersController < ApplicationController
  def create
    new_customer = Customer.new(customer_params)
    if Customer.find_by(email: params[:email])
      render json: { errors: 'One or all of the following have occured: Email already exist, passwords do not match, or field is missing'}, status: 400 
    elsif new_customer.save
      render json: CustomerSerializer.create_customer(new_customer), status: 201
    else
    render json: { errors: "One or all of the following have occured: Email already exist or field is missing"}, status: 400     end
  end

  private 
  def customer_params
    params.permit(:first_name, :last_name, :email, :address)
  end
end
