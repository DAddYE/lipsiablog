class LipsiaBlogService < ActionWebService::Base
  include ActionController::UrlWriter
  
  def settings
    Setting.first
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

protected

  def authenticate(name, args)
    method = self.class.web_service_api.api_methods[name]

    # Coping with backwards incompatibility change in AWS releases post 0.6.2
    begin
      h = method.expects_to_hash(args)
      raise "Invalid login" unless @account=Account.authenticate(h[:username], h[:password])
    rescue NoMethodError
      username, password = method[:expects].index(:username=>String), method[:expects].index(:password=>String)
      raise "Invalid login" unless @account=Account.authenticate(args[username], args[password])
    end
  end
end
