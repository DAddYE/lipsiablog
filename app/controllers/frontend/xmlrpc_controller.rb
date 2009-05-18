require 'lipsia_blog_service'
require 'meta_weblog_service'
require 'blogger_service'

class Frontend::XmlrpcController < ApplicationController
  web_service_dispatching_mode :layered
  web_service_exception_reporting true

  web_service :metaWeblog, MetaWeblogService.new
  web_service :mt,         MovableTypeService.new
  web_service :blogger,    BloggerService.new

  alias xmlrpc api
end