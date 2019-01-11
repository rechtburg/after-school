class IndexController < ApplicationController
  def index
    if signed_in?
      redirect_to posts_path
    else
      redirect_to login_path
    end
  end 
end