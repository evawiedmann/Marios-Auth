class HomeController < ApplicationController

  def index
    @product = Product.all
    render :index

  end
end
