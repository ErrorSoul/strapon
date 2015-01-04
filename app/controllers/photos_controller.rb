class PhotosController < ApplicationController
  respond_to :json

  
  def show
    
    @comments = Comment.where('created_at > ?', Time.at((params[:id]).to_i/1000))
    render json: { comments: @comments }, :include => {:user=> {only: [:name, :nickname, :image]}}
  end


  def create
    @photo = Photo.new(photo_params)
    if @photo.save 
      
      render json: { url: @photo.asset.url }
    else
      render json: {errors: @photo.errors.full_messages}
    end
  end
  private 
  
  def photo_params
    params.require(:photo).permit(:asset)
  end
 
      
end
