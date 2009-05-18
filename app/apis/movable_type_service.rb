module MovableTypeStructs
  class PostTitle < ActionWebService::Struct
    member :dateCreated,  :time
    member :userid,       :string
    member :postid,       :string
    member :title,        :string
  end

  class CategoryList < ActionWebService::Struct
    member :categoryId,   :string
    member :categoryName, :string
  end

  class CategoryPerPost < ActionWebService::Struct
    member :categoryName, :string
    member :categoryId,   :string
    member :isPrimary,    :bool
  end

  class TextFilter < ActionWebService::Struct
    member :key,    :string
    member :label,  :string
  end

  class TrackBack < ActionWebService::Struct
    member :pingTitle,  :string
    member :pingURL,    :string
    member :pingIP,     :string
  end
end


class MovableTypeApi < ActionWebService::API::Base
  inflect_names false

  api_method :getCategoryList,
    :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string} ],
    :returns => [[MovableTypeStructs::CategoryList]]

  api_method :getPostCategories,
    :expects => [ {:postid => :string}, {:username => :string}, {:password => :string} ],
    :returns => [[MovableTypeStructs::CategoryPerPost]]

  api_method :getRecentPostTitles,
    :expects => [ {:blogid => :string}, {:username => :string}, {:password => :string}, {:numberOfPosts => :int} ],
    :returns => [[MovableTypeStructs::PostTitle]]

  api_method :setPostCategories,
    :expects => [ {:postid => :string}, {:username => :string}, {:password => :string}, {:categories => [MovableTypeStructs::CategoryPerPost]} ],
    :returns => [:bool]

  api_method :supportedMethods,
    :expects => [],
    :returns => [[:string]]

  api_method :supportedTextFilters,
    :expects => [],
    :returns => [[MovableTypeStructs::TextFilter]]

  api_method :getTrackbackPings,
    :expects => [ {:postid => :string}],
    :returns => [[MovableTypeStructs::TrackBack]]

  api_method :publishPost,
    :expects => [ {:postid => :string}, {:username => :string}, {:password => :string} ],
    :returns => [:bool]
end


class MovableTypeService < LipsiaBlogService
  web_service_api MovableTypeApi

  before_invocation :authenticate, :except => [:getTrackbackPings, :supportedMethods, :supportedTextFilters]

  def getRecentPostTitles(blogid, username, password, numberOfPosts)
    Post.all(:all,:order => "created_at DESC", :limit => numberOfPosts).collect do |post|
      MovableTypeStructs::PostTitle.new(
            :dateCreated => post.created_at,
            :userid      => blogid.to_s,
            :postid      => post.id.to_s,
            :title       => post.title
          )
    end
  end

  def getCategoryList(blogid, username, password)
    Category.all.collect do |c|
      MovableTypeStructs::CategoryList.new(
          :categoryId   => c.id,
          :categoryName => c.name
        )
    end
  end

  def getPostCategories(postid, username, password)
    Post.find(postid).categories.collect do |c|
      MovableTypeStructs::CategoryPerPost.new(
          :categoryName => c.name,
          :categoryId   => c.id,
          :isPrimary    => 0
        )
    end
  end

  def setPostCategories(postid, username, password, categories)
    post = Post.find(postid)
    post.categories.clear if categories != nil

    for c in categories
      category = Category.find(c['categoryId'])
      post.categories << category
    end
    
    post.save
  end

  def supportedMethods()
    MovableTypeApi.api_methods.keys.collect { |method| method.to_s }
  end

  # Support for markdown and textile formatting dependant on the relevant
  # translators being available.
  def supportedTextFilters()
    []
  end

  def getTrackbackPings(postid)
    []
  end

  def publishPost(postid, username, password)
    post = Post.find(postid)
    post.draft = false
    post.save
  end
end
