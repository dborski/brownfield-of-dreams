class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    begin
      playlist_id = params[:tutorial][:playlist_id]

      if playlist_id
        tutorial = Tutorial.new.create_playlist(playlist_id)
        Tutorial.new.create_playlist_videos(playlist_id, tutorial)
        flash[:success] = "Successfully created tutorial. #{view_context.link_to('View it here', tutorial_path(tutorial))}"
      else
        tutorial = Tutorial.create(tutorial_params)
        flash[:success] = "Successfully created tutorial."
      end
      redirect_to admin_dashboard_path
    rescue StandardError
      flash[:error] = "There was an issue creating the tutorial."
      redirect_to tutorial_new_path
    end
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
    flash[:success] = "#{tutorial.title} deleted." if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end
end
