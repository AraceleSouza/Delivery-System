class ProductModelsController < ApplicationController 
  def index
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @product_models = ProductModel.all
  end

  def new
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @product_model = ProductModel.new
  end

  def create
    @shipping_company =  ShippingCompany.find(params[:shipping_company_id])
    @product_model = ProductModel.new(product_model_params)
    @product_model.shipping_company = @shipping_company
    if  @product_model.save() 
      redirect_to shipping_company_product_models_path(@shipping_company), notice: "Produto cadastrado com sucesso."
    else
      flash.now[:notice] = 'Não foi possível cadastrar o produto.'
      render 'new'
    end
  end
  
  private

  def product_model_params
    params.require(:product_model).permit(:name, :weight, :width, :height, :depth, :sku)
  end
 
end