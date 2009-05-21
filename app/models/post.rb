class Post < ActiveRecord::Base
  # Validations
  validates_presence_of :name, :description_short, :account_id
  
  # Relations
  belongs_to              :account
  has_and_belongs_to_many :categories
  has_many                :comments,    :dependent => :destroy
  has_many_attachments    :attachments, :dependent => :destroy
  
  # Named Scope
  named_scope             :publics,      :conditions => { :draft => false }, :order => "position ASC, created_at DESC"

  # Callbacks
  after_create  :deliver_notification
  after_save    :update_counter
  after_destroy :update_counter

  Setting.menu_range.each do |i|
    named_scope "for_menu_#{i}", :conditions => { :draft => false, :menu => i }, :order => "position ASC, created_at DESC"
  end
  
  def to_param
    id.to_s + "-" + name.downcase.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/-+$/, '').gsub(/^-+$/, '')
  end
  
  def static?
    menu != 0
  end
  
  # We rewrite that for accept ids in a uniq string
  def category_ids=(new_value)
    new_value = new_value.split(",").collect(&:to_i)
    ids = (new_value || []).reject { |nid| nid.blank? }
    self.categories=Category.find(ids)
  end
  
  def tags_formatted
    return [] if tags.blank?
    t = tags.include?(",") ? tags.split(", ") : tags.split(" ")
    t.collect { |t| t.downcase.strip }
  end
  
  def description_for_feed
    Setting.first.feed_complete? ? description_short_formatted+description_long_formatted : description_short_formatted
  end
  
  def description_short_formatted
    format(description_short)
  end
  
  def description_long_formatted
    format(description_long)
  end
  
private
  def deliver_notification
    Notifier.deliver_post(self)
  end
  
  def update_counter
    Category.all.each { |c| c.update_attribute(:posts_count, c.posts.length) }
  end
  
  # This method format and higlight code for you.
  # 
  # You need only provide <code lang="XXX"> where XXX is one of the following
  # 
  #   "c", "css", "debug", "delphi", "diff", "html", "java", "java_script", "json", 
  #   "nitro_xhtml", "plaintext", "rhtml", "ruby", "scheme", "sql", "xml", "yaml"
  # 
  def format(text)
    return "" if text.blank?
    text = text =~ /\A<p>/ ? text : "<p>#{text}</p>"
    # check for pre/code
    text.scan(/((?:<pre>)?<code\s?(?:lang="(.*?)")?>(.*?)<\/code>(?:<\/pre>)?)/m).each do |m|
      match, lang, code = *m
      lang = :ruby if !CodeRay::Scanners.list.include?(lang)
      text.gsub!(match, CodeRay.scan(code.strip, lang).div(:css => :class))
    end
    text
  end
end
