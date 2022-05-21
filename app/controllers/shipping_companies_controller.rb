class ShippingCompaniesController < ApplicationController 
  def index
    @shipping_companies = ShippingCompany.all
  end

  def new
    @shipping_company = ShippingCompany.new
  end

  def show
    @shipping_company = ShippingCompany.find(params[:id])
  end

  def create
    @shipping_company = ShippingCompany.new(params.require(:shipping_company).permit(:corporate_name, :fantasy_name, :email, 
    :cnpj , :address, :city, :state, :cep))
    if @shipping_company.save()
      redirect_to shipping_companies_path, notice: "Transportadora cadastrada com sucesso."
    else
      flash.now[:notice] = "Transportadora não cadastrada."
      render'new'
    end
  end
end


