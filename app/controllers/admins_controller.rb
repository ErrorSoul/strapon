class AdminsController < ApplicationController
  protect_from_forgery with: :exception
  include SessionsHelper
  layout "admin"
  def index
  end
end
