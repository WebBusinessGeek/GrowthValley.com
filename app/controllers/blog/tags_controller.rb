class Blog::TagsController < Blog::ApplicationController
  def show
    @tag = retrieve_tag
    if @tag
      @page = nil
      @posts = @tag.posts_with_tag
    else
      redirect_to blog_path ,notice: "No post found with label \"#{params[:tag]}\""
    end
  end

  private
  def retrieve_tag
    Blog::Tag.where("lower(name) = ?", params[:tag].mb_chars.downcase.to_s).first
  end
end