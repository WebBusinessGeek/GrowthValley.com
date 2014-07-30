module Blog
  module HtmlHelper
    def activable_li_tag(*url, &block)
      content_tag :li, capture(&block), :class => ("active" if url.any?{|u| current_page?(u)})
    end

    def activable_li_tag_with_link(title, *url)
      activable_li_tag *url do
        link_to(title, url.first)
      end
    end

    def sidebar_section_for(title, &block)
       content_tag(:section, capture(&block) ,class: 'widget') 
     end

   def sidebar_section(title, &block)
     content_tag(:section, class: 'widget') do
       content_tag(:div, content_tag(:h5, title), class: "blog-header") +
           capture(&block)
     end
   end
  end
end