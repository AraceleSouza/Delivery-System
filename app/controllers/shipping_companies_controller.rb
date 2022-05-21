class ShippingCompaniesController < ApplicationController 
  before_action :authenticate_admin!, only: [:index, :new, :show, :create, :edit, :update]

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
    @shipping_company = ShippingCompany.new(shipping_company_params)
    if @shipping_company.save()
      redirect_to shipping_companies_path, notice: "Transportadora cadastrada com sucesso."
    else
      flash.now[:notice] = "Transportadora não cadastrada."
      render'new'
    end
  end

  def edit 
    @shipping_company = ShippingCompany.find(params[:id])
  end

  def update
    @shipping_company = ShippingCompany.find(params[:id])     
    if @shipping_company.update(shipping_company_params)
      redirect_to shipping_companies_path(@shipping_company.id), notice: 'Transportadora atualizada com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível atualizar a transportadora.'
      render'edit'
    end
  end

  private

  
  def shipping_company_params
    params.require(:shipping_company).permit(:corporate_name, :fantasy_name, :email, 
    :cnpj , :address, :city, :state, :cep)
  end
end


