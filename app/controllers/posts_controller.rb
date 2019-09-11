class PostsController < ApplicationController
  # set up instance variables
  before_action :set_post, only: [:show, :edit, :update, :vote]

  # all actions need to require user (defined in application controller) EXCEPT for show and index actions
  # this locks down the URL at the controller level
  before_action :require_user, except: [:show, :index]

  def index
    @posts = Post.all.sort_by { |x| x.total_votes }.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user # current_user will exist. can't execute this action without a user (before_action)
                              
    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "This post was updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    # vote = params[:vote] == "true"
    # @post.votes << Vote.create(vote: vote, user_id: current_user.id)
    # flash[:notice] = "Your vote was counted."
    # redirect_to posts_path

    Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    flash[:notice] = "Your vote was counted."
    redirect_to :back    
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end


