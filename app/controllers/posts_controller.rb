class PostsController < ApplicationController
  before_action :authenticate

  def index
    @posts = Current.user.posts.page(page_number)

    respond_with @posts
  end

  def show
    @post = Current.user.posts.find(params[:id])

    respond_with @post
  end

  def create
    @post = Current.user.posts.create!(post_params)

    respond_with @post, location: nil
  end

  def update
    @post = find_post

    respond_with @post
  end

  def destroy
    @post = find_post
    @post.destroy

    respond_with @post
  end

  private

  def find_post
    Current.user.posts.find(params[:id])
  end

  def post_params
    params.permit(:title, :description, :active)
  end
end
