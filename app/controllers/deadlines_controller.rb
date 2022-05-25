class DeadlinesController < ApplicationController 
  def index
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @deadlines = Deadline.all
  end
end