class Api::V1::TeasController < ApplicationController
  def index
    teas = Tea.all
    render json: TeasSerializer.get_teas(teas), status: 200
  end

  def create
    new_tea = Tea.new(tea_params)
    if new_tea.save
      render json: TeaSerializer.create_tea(new_tea), status: 201
    else
      render json: { errors: "something went wrong, param may be missing"}, status: 400
    end
  end

  def destroy
    tea = tea.find_by(id: params[:id])
    tea.destroy
  end

  private 
  def tea_params
    params.permit(:name, :description, :temp, :brew_time)
  end
end
