module Blog
  module ApplicationHelper
    include Blog::HtmlHelper
    include Blog::TagsHelper


    def twitter_icon
      social_icon("twitter", "http://twitter.com/#{Figaro.env.twitter_username}", Figaro.env.twitter_username)
    end

    def linkedin_icon
      social_icon("linkedin", Figaro.env.linkedin_url, Figaro.env.linkedin_url)
    end

    def googleplus_icon
      social_icon("google-plus", Figaro.env.google_plus_account_url, Figaro.env.google_plus_account_url)
    end

    def facebook_icon
      social_icon("facebook", Figaro.env.facebook_url, Figaro.env.facebook_url)
    end

    def social_icon(foundicon, url, setting)
      return if setting.nil? || !setting
      content_tag :a, href: url, class: "social", target: "_blank" do
        content_tag :i, class: "foundicon-#{foundicon}" do # using an empty content tag for foundicons to appear. TODO: try to do otherwise and use only tag method
        end
      end
    end
  end
end