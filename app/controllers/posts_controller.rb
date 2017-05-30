class PostsController < ApplicationController
  before_action :authenticate

  def index
    posts = Current.user.posts.page(page_number)

    respond_with posts
  end

  def show
    respond_with post
  end

  def create
    post = Current.user.posts.create!(post_params)

    respond_with post, location: nil
  end

  def update
    post.update!(post_params)

    respond_with post
  end

  def destroy
    post.destroy

    respond_with post
  end

  private

  def post
    @post ||= Current.user.posts.find(params[:id])
  end

  def post_params
    params.permit(:title, :description, :active)
  end
end
