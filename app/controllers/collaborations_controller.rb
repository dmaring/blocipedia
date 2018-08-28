class CollaborationsController < ApplicationController
  def show
    @wiki = Wiki.find(params[:id])
    @collaborations = @wiki.collaborations
  end

  def new
    @collaboration = Collaboration.new
  end

  def create
    @collaboration = Collaboration.new
    @collaboration.user_id = params[:user_id]
    @collaboration.wiki_id = params[:wiki_id]

    if @collaboration.save

      flash[:notice] = "Collaborator was saved."
      redirect_to collaborations_path(@collaboration)

    else

      flash.now[:alert] = "There was an error saving the Collaborator."
      render :new
    end
  end

  def destroy
    @collaboration = Collaboration.find(params[:id])
    if @collaboartion.destroy
      flash[:notice] = "\"#{@collaboration}\" was deleted successfully."
      redirect_to(collaborations_path)
    else
      flash.now[:alert] = "There was an error deleting the collaborator."
      redirect_to(collaborations_path)
      #render(:show)
    end
  end

end
