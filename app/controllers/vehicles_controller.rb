class VehiclesController < ApplicationController 
  def index
    @shipping_company =  ShippingCompany.find(params[:shipping_company_id])
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end
end