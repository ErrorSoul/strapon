class SessionsController < ApplicationController
  respond_to :json
  
  def create
    author = Author.find_by(login: params[:author][:login])
    if author && author.authenticate(params[:author][:password])
      sign_in author
      puts current_user, "fdfdf"
      render json: { author: author, authorized: 'true' }
    else
      render json: { authorized: 'false'}
    end
  end

  def destroy
    sign_out
    render json: {authorized: 'false'}
  end

 private 
	def x 
	puts current_user, "fdfd"
	end
end
