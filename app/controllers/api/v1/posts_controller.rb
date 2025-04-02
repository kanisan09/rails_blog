class Api::V1::PostsController < ApplicationController
  def index
    @posts = Post.all
    render "index"
  end

  def show
    @post = Post.find(params[:id])
    render "show"
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      if params[:post][:image].present?
        @post.image.attach(params[:post][:image])
      end
      redirect_to api_v1_post_path(@post), notice: "投稿を作成しました。"
    else
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      if params[:post][:image].present?
        @post.image.attach(params[:post][:image])
      end
      redirect_to api_v1_post_path(@post), notice: "投稿を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
    redirect_to api_v1_posts_path, notice: "投稿を削除しました。"
    else
      redirect_to api_v1_post_path(@post), alert: "投稿削除に失敗しました。"
    end
  end

private
def post_params
  params.require(:post).permit(:title, :content, :image)
end
end
