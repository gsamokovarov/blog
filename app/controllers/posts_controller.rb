class PostsController < ApplicationController
  def index
    @posts = Post.all.page(page_number)

    headers['Custom-Header'] = 'Some Value'

    respond_with @posts, each_serializer: PostSerializer
  end

  def show
    @post = Post.find(params[:id])

    respond_with @post
  end

  def new
    @post = Post.new

    respond_with @post
  end

  def edit
    @post = find_post

    respond_with @post
  end

  def create
    @post = Post.new(post_params)

    respond_with @post
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
    Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :active)
  end
end
