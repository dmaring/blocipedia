class WikisController < ApplicationController

  def index
    if current_user.admin?
      @wikis= Wiki.admin_scope
    else
      @wikis = Wiki.standard_scope(current_user)
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    # markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    # params[:wiki][:body] = markdown.render(params[:wiki][:body])
    @wiki.assign_attributes(wiki_params)
    @wiki.user_id = current_user.id

    authorize @wiki
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
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    params[:wiki][:body] = markdown.render(params[:wiki][:body])
    # @wiki.title = params[:wiki][:title]
    # @wiki.body = params[:wiki][:body]
    # @wiki.private = params[:wiki][:private]
    @wiki.assign_attributes(wiki_params)
    @wiki.user_id = current_user.id
    authorize @wiki
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
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to(wikis_path)
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      redirect_to(wikis_path)
      #render(:show)
    end
  end

  private
    def wiki_params
      params.require(:wiki).permit(:title, :body, :private)
    end

end
