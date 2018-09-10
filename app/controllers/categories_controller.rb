class CategoriesController < ApplicationController
  def index
    @categories = Category.all.page(params[:page]).per(5)
  end

  def show
    @category = Category.find(params[:id])
    respond_to do |format|
        format.html # show.html
        format.json { render json: @categories}
    end
  end
end
