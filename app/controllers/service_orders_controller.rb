class ServiceOrdersController < ApplicationController 
  #before_action :authenticate_admin!
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
    @service_orders = ServiceOrder.where("code LIKE ?", "%#{@code}%")
  end

  def accept
    @service_order = ServiceOrder.find(params[:id])
    @service_order.accept!
    redirect_to service_order_path(@service_order.id), notice: 'Pedido aceito com sucesso!'
  end

  def recused
    @service_order = ServiceOrder.find(params[:id])
    @service_order.recused!
    redirect_to service_order_path(@service_order.id), notice: 'Pedido recusado com sucesso!'
  end

end