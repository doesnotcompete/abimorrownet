class ProductsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!

  def new
    authorize :product, :create?
  end

  def create
    authorize :product, :create?

    product = Product.create(product_params)

    if product.persisted?
      redirect_to product
    else
      flash[:notice] = "Fehler beim Speichern."
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    authorize @product
  end

  def index
    @products = Product.all
    authorize @products
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  def update
    @product = Product.find(params[:id])
    authorize @product
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, notice: "Fehler."
    end
  end

  def destroy
    @product = Product.find(params[:id])

    authorize @product
    @product.destroy!
    redirect_to products_url, notice: "Produkt gelöscht."
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :shippable, :available, :ticketable, :max_people)
  end
end
