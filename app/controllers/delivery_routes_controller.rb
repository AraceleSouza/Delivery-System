class DeliveryRoutesController < ApplicationController 
  def new
    @service_order = ServiceOrder.find(params[:service_order_id])
    @delivery_route = DeliveryRoute.new
    @service_orders = ServiceOrder.all
  end

  def create
    @service_order = ServiceOrder.find(params[:service_order_id])
    delivery_route_params = params.require(:delivery_route).permit(:service_order_id, :current_address, 
                                                :exit_address, :estimated_delivery_date, :current_date)
    @delivery_route = DeliveryRoute.new(delivery_route_params)
    @delivery_route.service_order = @service_order
    if @delivery_route.save
      redirect_to @service_order, notice: 'Rota atualizada com sucesso.'
    end
  end
end