class ServiceOrdersController < ApplicationController 
  def index
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
    else
      @shipping_companies = ShippingCompany.all
      @vehicles = Vehicle.all
      @product_models = ProductModel.all
      flash.now[:notice] = 'Não foi possível registrar o pedido.'
    render 'new'
    end
  end

  def search
    @code = params["query"]
    @service_order = ServiceOrder.find_by(code: params["query"])
  end

end