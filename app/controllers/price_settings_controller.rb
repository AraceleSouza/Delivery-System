class PriceSettingsController < ApplicationController 
  def index
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @price_settings = PriceSetting.all
  end

  def new
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @price_setting = PriceSetting.new
  end

  def create
    @shipping_company =  ShippingCompany.find(params[:shipping_company_id])
    @price_setting = PriceSetting.new(price_settings_params)
    @price_setting.shipping_company = @shipping_company
    if @price_setting.save() 
      redirect_to shipping_company_price_settings_path(@shipping_company), notice: "Preço cadastrado com sucesso."
    else
      flash.now[:notice] = "Preço não cadastrado."
      render 'new'
    end
  end

  private

  def price_settings_params
    params.require(:price_setting).permit(:min_weight, :max_weight, :min_cubic_meter, :max_cubic_meter, :distance_value)
  end

end