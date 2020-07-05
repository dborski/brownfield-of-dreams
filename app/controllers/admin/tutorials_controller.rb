class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    if params[:tutorial][:playlist_id]
      new_tutorial = Tutorial.new.create_playlist(params[:tutorial][:playlist_id])
      new_tutorial_videos = Tutorial.new.create_playlist_videos(params[:tutorial][:playlist_id], new_tutorial)
    end
    flash[:success] = "Successfully created tutorial. #{view_context.link_to('View it here', tutorial_path(new_tutorial))}"
    redirect_to admin_dashboard_path
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end
end
