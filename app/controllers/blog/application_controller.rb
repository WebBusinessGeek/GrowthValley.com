class Blog::ApplicationController < ApplicationController
  include Blog::ControllerHelpers::User
  skip_before_filter :authenticate_user!
  layout "layouts/home_new"

  before_filter :recent_posts, :all_tags

  def recent_posts
    @recent_posts = Blog::Post.published.limit(3)
  end

  def all_tags
    @tags = Blog::Tag.order("name").select{|t| t.frequency > 0}
    #could use minmax here but it's only supported with ruby > 1.9'
    @tags_frequency_min = @tags.map{|t| t.frequency}.min
    @tags_frequency_max = @tags.map{|t| t.frequency}.max
  end

  def not_found
    # fallback to the default 404.html page from main_app.
    file = Rails.root.join('public', '404.html')
    if file.exist?
      render file: file.cleanpath.to_s.gsub(%r{#{file.extname}$}, ''),
         layout: false, status: 404, formats: [:html]
    else
      render action: "404", status: 404, formats: [:html]
    end
  end
end