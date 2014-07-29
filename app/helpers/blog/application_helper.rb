module Blog
  module ApplicationHelper
    include Blog::HtmlHelper
    include Blog::TagsHelper

    def blog_accurate_title
      content_for?(:title) ? ((content_for :title) + " | #{Settings.blog.site_name}") : Settings.blog.site_name
    end

    def twitter_icon
      social_icon("twitter", "http://twitter.com/#{Settings.blog.twitter_username}", Settings.blog.twitter_username)
    end

    def linkedin_icon
      social_icon("linkedin", Settings.blog.linkedin_url, Settings.blog.linkedin_url)
    end

    def googleplus_icon
      social_icon("gplus", Settings.blog.google_plus_account_url, Settings.blog.google_plus_account_url)
    end

    def facebook_icon
      social_icon("facebook", Settings.blog.facebook_url, Settings.blog.facebook_url)
    end

    def absolute_image_url(url)
      return url if url.starts_with? "http"
      request.protocol + request.host + url
    end

    def social_icon(foundicon, url, setting)
      return if setting.nil? || !setting
      content_tag :li do
        content_tag :a, href: url, target: "_blank", class: "s-icons #{foundicon}" do # using an empty content tag for foundicons to appear. TODO: try to do otherwise and use only tag method
        end
      end
    end
  end
end