xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.instruct! 'xml-stylesheet', :type=>"text/css", :href => url_for("/stylesheets/rss.css")

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/",
        "xmlns:trackback" => "http://madskills.com/public/xml/rss/module/trackback/" do
  xml.channel do
    xml.title Setting.first.name
    xml.link Setting.first.website
    xml.language "it-IT"
    xml.ttl "40"
    xml.description "Blog dedicato della LipsiaSoft s.r.l. dedicato alle tecnologie web come ruby on rails ..."
    
    for post in Post.for_menu_0.all(:limit => Setting.first.feed_limit)
      xml.item do
        xml.title post.name
        xml.description post.description_for_feed
        xml.pubDate post.created_at.rfc822
        xml.guid "urn:uuid:#{post.id}", "isPermaLink" => "false"
        author = post.account.full_name rescue "Davide D'Agostino"
        email  = post.account.email rescue nil
        author = "#{email} (#{author})"
        xml.author author
        xml.link post_url(post)
        for category in post.categories
          xml.category category.name
        end
        for tag in post.tags_formatted
          xml.category tag
        end
      end
    end
  end
end