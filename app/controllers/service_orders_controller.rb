class ServiceOrdersController < ApplicationController 
  def index
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @service_orders = ServiceOrder.all
  end

  def show
    @service_order = ServiceOrder.find(params[:id])
  end

  def new
    @service_order = ServiceOrder.new
    @shipping_companies = ShippingCompany.all
    @vehicles = Vehicle.all
    @product_models = ProductModel.all
  end

  def create
    service_order_params = params.require(:service_order).permit(:shipping_company_id, :vehicle_id, :product_model_id, :full_address, 
                                                        :customer_address, :customer_name, :estimated_delivery_date, :status)
    @service_order = ServiceOrder.new(service_order_params)
    if @service_order.save
      redirect_to @service_order, notice: 'Pedido registrado com sucesso.'
    #else
    #  flash.now[:notice] = 'Não foi possível cadastrar o pedido.'
    #render 'new'
    end
  end

end