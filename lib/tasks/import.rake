desc "Riformatta i vecchi file"
task :files => :environment do
  for post in Post.all
    paths = post.description_short.to_s.match(/(\/uploads\/\d{1,3})(?!_)/).to_a
    for path in paths
      post.description_short = post.description_short.to_s.gsub(path, "#{path}_")
    end
    paths = post.description_long.to_s.match(/(\/uploads\/\d{1,3})(?!_)/).to_a
    for path in paths
      post.description_short = post.description_long.to_s.gsub(path, "#{path}_")
    end
    post.save!
  end
end

desc "Riformatta i contenuti"
task :contents => :environment do
  for post in Post.all
    post.description_short = post.description_short.to_s.gsub("<typo:code>", "<pre><code>")
    post.description_short = post.description_short.to_s.gsub("</typo:code>", "</pre></code>")
    post.description_long  = post.description_long.to_s.gsub("<typo:code>", "<code><pre>")
    post.description_long  = post.description_long.to_s.gsub("</typo:code>", "</code></pre>")
    post.save!
  end  
end

desc "Riformatta i nome dei files"
task :file_names => :environment do
  for attachment in Attachment.all
    attachment.update_attribute(:attached_file_name, attachment.attached_file_name.gsub("original_", ""))
    File.rename(attachment.file.path(:gsub).gsub(/gsub/, "original"), attachment.file.path)
  end
end