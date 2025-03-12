class Api::V1::PostsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @posts = Post.all
    render "index"
  end

  def show
    @post = Post.find(params[:id])
    render "show"
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      rendirect_to api_v1_post_path(@post), notice: "投稿を作成しました。"
    else
      render "new"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render @post.update(post_params)
      redirect_to api_v1_post_path(@post), notice: "投稿を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to api_v1_posts_path, notice: "投稿を削除します"
  end

private
def post_params
  params.require(:post).permit(:title, :content)
end
end
