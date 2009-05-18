module FrontendHelper

  def lps_box(title, options={}, &block)
    html = <<-HTML
      <div class="lps-box" style="#{options[:style]}">
        <div class="lps-box-hr"></div>
        <div class="lps-box-body">
          <div class="bold">#{title}</div>
          #{capture(&block)}
        </div>
        <div class="lps-box-ft"></div>
      </div>
    HTML
    concat(html)
  end
  
  def comment_box(comment, options={})
    html = <<-HTML
      <div class="comment-box" style="#{options[:style]}">
        <div class="comment-box-hr"></div>
        <div class="comment-box-body">
          <div>
            <b>#{comment.website.blank? ? comment.name : link_to(comment.name, comment.website, :target=>:_blank, :rel => :nofollow)}</b>
            <span class="small">write #{comment.created_at.strftime("%d/%m/%y at %H:%M")}</span>
          </div>
          <p>#{simple_format h(comment.description)}</p>
        </div>
        <div class="comment-box-ft"></div>
      </div>
    HTML
  end
  
  def warning(text="Post not found")
    content_tag(:div, text, :class => "warning")
  end
  
  def post_path(post)
    if post.menu == 0
      options = { :action => :post, :year => post.created_at.year, :month => post.created_at.month, :day => post.created_at.day }
    else
      options = { :action => :static }
    end
    options.merge(:controller => "frontend/base", :id => post)
  end
  
  def post_url(post)
    url_for post_path(post).merge(:host => Setting.first.website.gsub("http://", ""))
  end

end