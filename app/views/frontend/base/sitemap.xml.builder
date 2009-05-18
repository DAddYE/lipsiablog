xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.urlset "xmlns"=>"http://www.google.com/schemas/sitemap/0.84" do
  for post in Post.publics.all
    xml.url do
      xml.loc post_url(post)
      xml.lastmod post.updated_at.xmlschema
      xml.priority 0.8
    end    
  end
end