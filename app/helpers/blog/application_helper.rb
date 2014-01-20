module Blog
  module ApplicationHelper
    include Blog::HtmlHelper
    include Blog::TagsHelper
  end
end