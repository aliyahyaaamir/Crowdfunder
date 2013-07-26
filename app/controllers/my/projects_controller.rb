class My::ProjectsController < ApplicationController

  before_filter :require_login
  def index
  	@myprojects = current_user.projects
  end

  def new
  	@myproject = current_user.projects.new
  end

  def create
    @myproject = current_user.projects.new(params[:project])
    @myproject.user_id = current_user.id
    if @myproject.save
      redirect_to my_projects_path, :notice => "Your Project was saved"
    else
      render "new"
    end
  end

  def update
    @myproject = current_user.projects.find(params[:id])

    if @myproject.update_attributes(params[:project])
      redirect_to my_projects_path, :notice => "There you go!"
    else
      render "edit"
    end
  end

  def show
  end

  def edit
    if current_user.projects.exists?(params[:id])
      @myproject = current_user.projects.find(params[:id])
    else
      redirect_to root_path, :notice => "doesn't exist"
    end
end

end
