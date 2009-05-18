module BloggerStructs
  class Blog < ActionWebService::Struct
    member :url,      :string
    member :blogid,   :string
    member :blogName, :string
  end
  class User < ActionWebService::Struct
    member :userid, :string
    member :firstname, :string
    member :lastname, :string
    member :nickname, :string
    member :email, :string
    member :url, :string
  end
end


class BloggerApi < ActionWebService::API::Base
  inflect_names false

  api_method :deletePost,
    :expects => [ {:appkey => :string}, {:postid => :int}, {:username => :string}, {:password => :string},
                  {:publish => :bool} ],
    :returns => [:bool]

  api_method :getUserInfo,
    :expects => [ {:appkey => :string}, {:username => :string}, {:password => :string} ],
    :returns => [BloggerStructs::User]

  api_method :getUsersBlogs,
    :expects => [ {:appkey => :string}, {:username => :string}, {:password => :string} ],
    :returns => [[BloggerStructs::Blog]]

  api_method :newPost,
    :expects => [ {:appkey => :string}, {:blogid => :string}, {:username => :string}, {:password => :string},
                  {:content => :string}, {:publish => :bool} ],
    :returns => [:int]
end


class BloggerService < LipsiaBlogService
  web_service_api BloggerApi
  before_invocation :authenticate

  def deletePost(appkey, postid, username, password, publish)
    post = Post.find(postid)
    post.destroy
    true
  end

  def getUserInfo(appkey, username, password)
    BloggerStructs::User.new(
      :userid => username,
      :firstname => "",
      :lastname => "",
      :nickname => username,
      :email => username,
      :url => settings.website
    )
  end

  def getUsersBlogs(appkey, username, password)
    [BloggerStructs::Blog.new(
      :url      => settings.website,
      :blogid   => settings.id,
      :blogName => settings.name
    )]
  end

  def newPost(appkey, blogid, username, password, content, publish)
    title, categories, body = content.match(%r{^<title>(.+?)</title>(?:<category>(.+?)</category>)?(.+)$}mi).captures rescue nil

    post                   = @account.posts.build
    post.description_short = body || content || ''
    post.title             = title || content.split.slice(0..5).join(' ') || ''
    post.draft             = !publish
    post.save

    if categories
      categories.split(",").each do |c|
        post.categories << Category.find_by_name(c.strip) rescue nil
      end
    end

    post.id
  end

end
