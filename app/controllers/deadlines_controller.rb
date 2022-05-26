class DeadlinesController < ApplicationController 
  def index
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @deadlines = Deadline.all
  end

  def new
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @deadline = Deadline.new
  end

  def create
    @shipping_company =  ShippingCompany.find(params[:shipping_company_id])
    @deadline = Deadline.new(deadline_params)
    @deadline.shipping_company = @shipping_company
    if @deadline.save() 
      redirect_to shipping_company_deadlines_path(@shipping_company), notice: "Prazo cadastrado com sucesso."
    else
      flash.now[:notice] = "Prazo não cadastrado."
      render 'new'
    end
  end
  private

  def deadline_params
    params.require(:deadline).permit(:min_distance, :max_distance, :deadline_in_days )
  end
end