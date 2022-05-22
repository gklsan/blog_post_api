class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:update, :destroy]

  def index
    render json: Post.all.map {|post| PostSerializer.new(post).serializable_hash }
  end

  def create
    post = Post.create!(posts_params)
    if post
      render json: PostSerializer.new(post).serializable_hash
    else
      render json: { message: "Can't create the post. #{post.message}" }
    end
  end

  def update
    if @post.update(post_params)
      render json: PostSerializer.new(@post).serializable_hash
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

  def posts_params
    params.permit(posts: [:title, :description, :user_id, comments_attributes: [:content, :user_id]]).require(:posts)
  end

  def post_params
    params.require(:post).permit([:id, :title, :description, :user_id, comments_attributes: [:id, :content, :user_id]])
  end
end
