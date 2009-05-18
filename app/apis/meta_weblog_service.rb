module MetaWeblogStructs
  class Post < ActionWebService::Struct
    member :description,        :string
    member :title,              :string
    member :postid,             :string
    member :url,                :string
    member :link,               :string
    member :permaLink,          :string
    member :categories,         [:string]
    member :mt_text_more,       :string
    member :mt_keywords,        :string
    member :mt_allow_comments,  :int
    member :mt_allow_pings,     :int
    member :mt_convert_breaks,  :string
    member :mt_tb_ping_urls,    [:string]
    member :dateCreated,        :time
  end

  class MediaObject < ActionWebService::Struct
    member :bits, :string
    member :name, :string
    member :type, :string
  end

  class Url < ActionWebService::Struct
    member :url, :string
  end
end


class MetaWeblogApi < ActionWebService::API::Base
  inflect_names false

  api_method :getCategories,
    :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string} ],
    :returns => [[:string]]

  api_method :getPost,
    :expects => [ {:postid => :string}, {:username => :string}, {:password => :string} ],
    :returns => [MetaWeblogStructs::Post]

  api_method :getRecentPosts,
    :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string}, {:numberOfPosts => :int} ],
    :returns => [[MetaWeblogStructs::Post]]

  api_method :deletePost,
    :expects => [ {:appkey => :string}, {:postid => :string}, {:username => :string}, {:password => :string}, {:publish => :int} ],
    :returns => [:bool]

  api_method :editPost,
    :expects => [ {:postid => :string}, {:username => :string}, {:password => :string}, {:struct => MetaWeblogStructs::Post}, {:publish => :int} ],
    :returns => [:bool]

  api_method :newPost,
    :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string}, {:struct => MetaWeblogStructs::Post}, {:publish => :int} ],
    :returns => [:string]

  api_method :newMediaObject,
    :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string}, {:data => MetaWeblogStructs::MediaObject} ],
    :returns => [MetaWeblogStructs::Url]

end


class MetaWeblogService < LipsiaBlogService
  web_service_api MetaWeblogApi
  before_invocation :authenticate

  def getCategories(blogid, username, password)
    Category.all.collect { |c| c.name }
  end

  def getPost(postid, username, password)
    post = Post.find(postid)
    post_dto_from(post)
  end

  def getRecentPosts(blogid, username, password, numberOfPosts)
    Post.find(:all, :include => :categories, :order => "created_at DESC").collect{ |c| post_dto_from(c) }
  end

  def newPost(blogid, username, password, struct, publish)
    post                   = @account.posts.build
    post.description_short = struct['description'] || ''
    post.name              = struct['title'] || ''
    post.draft             = !publish
    
    # Movable Type API support
    post.commentable       = struct['mt_allow_comments']
    post.description_long  = struct['mt_text_more'] || ''
    post.tags              = struct['mt_keywords'] || ''

    if !post.save
      raise post.errors.full_messages * ", "
    end

    if struct['categories']
      Category.all.each do |c|
        post.categories << c if struct['categories'].include?(c.name)
      end
    end

    post.id.to_s
  end

  def deletePost(appkey, postid, username, password, publish)
    post = Post.find(postid)
    post.destroy
    true
  end

  def editPost(postid, username, password, struct, publish)
    post                   = Post.find(postid)
    post.description_short = struct['description'] || ''
    post.name              = struct['title'] || ''

    # Movable Type API support
    post.commentable       = struct['mt_allow_comments']
    post.description_long  = struct['mt_text_more'] || ''
    post.tags              = struct['mt_keywords'] || ''

    if struct['categories']
      post.categories = []
      Category.all.each do |c|
        post.categories << c if struct['categories'].include?(c.name)
      end
    end
    
    RAILS_DEFAULT_LOGGER.info(struct['mt_tb_ping_urls'])
    post.save
    true
  end

  def newMediaObject(blogid, username, password, data)
    temp_file  = Attachment.get_temp_file(data['bits'], data['name'])
    attachment = @account.attachments.create!(:file => temp_file)
    MetaWeblogStructs::Url.new("url" => settings.website+attachment.url(:original))
  ensure
    Attachment.clear_temp_file(data['name'])
  end

  def post_dto_from(post)
    MetaWeblogStructs::Post.new(
      :description       => post.description_short,
      :title             => post.name,
      :postid            => post.id.to_s,
      :url               => post_url(post),
      :link              => post_url(post),
      :permaLink         => post_url(post),
      :categories        => post.categories.collect { |c| c.name },
      :mt_text_more      => post.description_long.to_s,
      :mt_keywords       => post.tags,
      :mt_allow_comments => post.commentable? ? 1 : 0,
      :mt_allow_pings    => 1,
      :mt_convert_breaks => "",
      :mt_tb_ping_urls   => [],
      :dateCreated       => (post.created_at.getutc.to_formatted_s(:db) rescue "")
    )
  end
end
