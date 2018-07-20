class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user_id = current_user.id

    if @wiki.save

      flash[:notice] = "Wiki was saved."
      redirect_to wiki_path(@wiki)

    else

      flash.now[:alert] = "There was an error saving the Wiki."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user_id = current_user.id

    if @wiki.save
      flash[:notice] = "Post was updated."
      redirect_to wiki_path(@wiki)
    else
      flash.now[:alert] = "There was an error saving the Wiki. Please try again."
      render(:edit)
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    # we call destroy on @post, if that call is successufl, we set a flash message and redirect the user to the posts index view. if destroy fails then we redirect the user to the show view using render :show
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to(wikis_path)
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      redirect_to(wikis_path)
      #render(:show)
    end
  end
end
