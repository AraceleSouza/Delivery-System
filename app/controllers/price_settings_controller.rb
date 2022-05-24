class PriceSettingsController < ApplicationController 
  def index
    @shipping_company =  ShippingCompany.find(params[:shipping_company_id])
    @price_settings = PriceSetting.all
  end
end