class Stores::CategoriesController < ApplicationController
  def show
    @category = Category.find_by(name: params[:name].capitalize)
    @photos = @category.photos.paginate(page: params[:page]).order('created_at DESC')
    @photographer = Store.find_by(url: params[:photographer])
  end
end