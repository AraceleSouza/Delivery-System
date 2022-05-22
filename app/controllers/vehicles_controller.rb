class VehiclesController < ApplicationController 
  def index
    @shipping_company =  ShippingCompany.find(params[:shipping_company_id])
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    @shipping_company =  ShippingCompany.find(params[:shipping_company_id])
    @vehicle = Vehicle.new
  end
  
  def create
    @shipping_company =  ShippingCompany.find(params[:shipping_company_id])
    @vehicle = Vehicle.new(vehicles_params)
    @vehicle.shipping_company = @shipping_company
    if @vehicle.save() 
      redirect_to shipping_company_vehicles_path(@shipping_company), notice: "Veículo cadastrado com sucesso."
    else
      flash.now[:notice] = "Veículo não cadastrado."
      render 'new'
    end
  end

    private

  def vehicles_params
    params.require(:vehicle).permit(:plate, :brand, :year_fabrication, :model, :freight)
  end
end