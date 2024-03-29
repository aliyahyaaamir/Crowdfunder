class SessionsController < ApplicationController
  def new
  end

  def create
  	 @user = login(params[:email], params[:password])
    if @user
  		redirect_to root_path, :notice => "Logged in!"
  	else
      flash.now[:alert] = "Invalid"
      render "new"
  	end
  end

  def destroy
  	logout
  	redirect_to root_path, :notice => "Bye"
  end
end
