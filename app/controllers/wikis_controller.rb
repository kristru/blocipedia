class WikisController < ApplicationController
  #before_action :require_sign_in, except: :show
  #before_action :authorize_user, except: [:show, :new, :create]

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
    @wiki = Wiki.create(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Woo hoo! A new Wiki."
      redirect_to @wiki
    else
      flash.now[:alert] = "Whoops. There was an error saving your Wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "Whoops. There was an error saving your Wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.delete
      flash[:notice] = "Bye Bye Wiki."
      redirect_to action: :index
    else
      flash.now[:alert] = "Stubborn little bugger. Please try again."
      render :show
    end
  end

#anything below this is private and can be accessed through Wikis

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end

  def authorize_user
    wiki = Wiki.find(params[:id])
    unless current_user == wiki.user || current_user.standard?
      flash[:alert] = "You must be a member to do that."
      redirect_to [wiki]
    end
  end

end
