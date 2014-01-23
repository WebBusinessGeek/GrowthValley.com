class Blog::PostsController < Blog::ApplicationController
  def index
    unless params[:query]
      @page = params[:page].nil? ? 1 : params[:page]
      @posts = Blog::Post.published.page(@page)
    else
      @posts = Blog::Post.search(params[:query])
    end
  end

  def show
    if blog_current_user
      @post = Blog::Post.default.where("url = :url", {url: params[:post_url]}).first
    else
      @post = Blog::Post.includes(:user).published.where("url = :url", {url: params[:post_url]}).first
    end
    if @post.nil?
      not_found
    end
  end

  def search
    @posts = Blog::Post.search(params[:query])
    render 'blog/posts/index'
  end
end
