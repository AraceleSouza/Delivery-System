class ShippingCompaniesController < ApplicationController 
  def index
    @shipping_companies = ShippingCompany.all
  end

  def new
    @shipping_company = ShippingCompany.new
  end
end