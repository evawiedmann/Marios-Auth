class ReviewsController < ApplicationController

  
  before_action :authenticate_user!, except: [:show, :index]
  def new
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new
    render :new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)

    if @review.save
      flash[:notice] = "Review added!"
      redirect_to product_path(@product)
    else
      flash[:alert] = "Review not added."
      render :new
    end
  end

  def edit
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    render :edit
  end
  def update
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "Review updated!"
      redirect_to product_path(@review.product)
    else
      flash[:notice] = "Review not updated."
      render :edit
    end
  end

  def show
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    render :show
  end


  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to product_path(@review.product)
  end

  private
  def review_params
    params.require(:review).permit(:author, :content_body, :rating)
  end
end
