class PledgesController < ApplicationController

  def new
  	if current_user
  		@project = Project.find(params[:project_id])
  		@pledge = @project.pledges.new
  		@pledge.user_id = current_user.id
  	else
  		redirect_to new_session_path, :notice => "Please login first."
  	end
  end

  def create

  	@project = Project.find(params[:project_id])
  	@pledge = @project.pledges.new(params[:pledge])
  	@pledge.user_id = current_user.id
  	@pledge.project_id = params[:project_id]

  	if @pledge.save
  		redirect_to project_path(@project), :notice => "Thanks for pledging"
  	else
  		render "new"
  	end
  end
end
