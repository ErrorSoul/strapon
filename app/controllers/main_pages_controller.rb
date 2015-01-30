class MainPagesController < ApplicationController

  def intro
  end
  
  def index
  end
  def cart
  end

  def robots
  end

  def sitemap
    path = Rails.root.join("public", "sitemaps", "sitemap.xml")
    if File.exists?(path)
      render xml: open(path).read
    else
      render text: "Sitemap not found.", status: :not_found
    end
  end

  def posts
    @posts = Post.all
    render json: {posts: @posts}
  end
end
