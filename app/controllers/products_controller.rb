class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]


  def index
    @product = Product.all
    render :index
  end

  def new
    @product = Product.new
    render :new  end

  def create
    @product = Product.new(product_params)
      if @product.save
        flash[:notice] = "Product added!"

        redirect_to products_path
      else
        flash[:alert] = "Product not added, try again."
        render :new
      end
    end

  def show
      @product = Product.find(params[:id])
      render :show
  end

  def edit
      @product = Product.find(params[:id])
      render :edit
  end

  def update
      @product= Product.find(params[:id])
      if @product.update(product_params)
        flash[:notice] = "Product updated!"
        redirect_to products_path
    else
        render :edit
    end
  end

  def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to products_path
  end
    private
  def product_params
      params.require(:product).permit(:name, :cost, :country_of_origin)
    end
  end
