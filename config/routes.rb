ActionController::Routing::Routes.draw do |map|
  map.namespace(:backend) do |backend|
    backend.resources :state_sessions
    backend.resources :boxes
    backend.resources :settings
    backend.resources :attachments
    backend.resources :comments
    backend.resources :categories
    backend.resources :posts
    backend.resources :accounts
    backend.resources :sessions
  end
  
  map.connect                 '',                             :controller => 'frontend/base',    :action => 'index'
  map.connect                 '/search/:query',               :controller => 'frontend/base',    :action => 'index'
  map.connect                 '/search',                      :controller => 'frontend/base',    :action => 'search'
  map.connect                 '/contact',                     :controller => 'frontend/base',    :action => 'contact'
  map.connect                 '/xmlrpc',                      :controller => 'frontend/xmlrpc',  :action => 'api'
  map.connect                 '/api',                         :controller => 'frontend/xmlrpc',  :action => 'xmlrpc'
  map.connect                 '/category/:id',                :controller => 'frontend/base',    :action => 'category'
  map.connect                 '/page',                        :controller => 'frontend/base',    :action => 'index'
  map.connect                 '/page/:start',                 :controller => 'frontend/base',    :action => 'page'
  map.connect                 '/post/:year/:month/:day/:id',  :controller => 'frontend/base',    :action => 'post',    :requirements => { :year => /\d{4}/, 
                                                                                                                                          :month => /\d{1,2}/, 
                                                                                                                                          :day => /\d{1,2}/ }
  map.connect                 '/page/static/:id',             :controller => 'frontend/base',    :action => 'static'
  map.connect                 '/post/:id/comment',            :controller => 'frontend/base',    :action => 'add_comment'
  map.connect                 '/feeds.rss',                   :controller => 'frontend/base',    :action => 'rss',     :format => :xml
  map.connect                 '/feeds/sitemap.xml',           :controller => 'frontend/base',    :action => 'sitemap', :format => :xml
  
  map.backend                 '/backend',                     :controller => 'backend/base',     :action => 'index'
  map.connect                 '/javascripts/:action.:format', :controller => 'javascripts'
  
  # Now we check for old urls
  map.connect '/articles/*old',       :controller => 'frontend/base', :action => 'moved_post'
  
  # Default routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
