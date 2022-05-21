class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:update, :destroy]

  def index
    render json: Post.all
  end

  def create
    post = Post.create(post_params)
    if post
      render json: post.serializable_hash(only: [:id, :title, :description], include: {user: { only: [:email] }})
    else
      render json: { message: "Can't create the post. #{post.message}" }
    end
  end

  def update
    if @post.update(post_params)
      render json: @post.serializable_hash(only: [:id, :title, :description], include: {user: { only: [:email] }})
    else
      render json: { message: "Can't update the post. #{@post.message}" }
    end
  end

  def destroy
    if @post&.destroy
      render json: { message: "Post #{@post.title} deleted successfully!" }
    else
      render json: { message: "Can't delete the post" }
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :user_id)
  end
end
