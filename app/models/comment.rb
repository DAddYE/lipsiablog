class Comment < ActiveRecord::Base
  # Validations
  validates_presence_of     :name,     :description, :ip, :post_id
  validates_length_of       :email,    :within => 3..100
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of       :website,  :with => /\Ahttp\:\/\//, :allow_blank => true
  
  # Named scoped
  named_scope :ham,         :conditions => "spam = 0", :order => :created_at
  
  # Relations
  belongs_to :post, :counter_cache => true
  
  # Callbacks
  after_create :deliver_notification
    
  # Validations of spam
  def validate
    
    # Questo è un piccolo controllo per evitare gli errori
    words_regex = Setting.first.spam_black_list.split(" ").reject { |w| w.size < 4 }
    
    # Costruisco valido le word black list
    black_list_regex = Regexp.new(words_regex.join("|"), true)
    errors.add_to_base("Il tuo commento risulta Spam!") if description =~ black_list_regex || name =~ black_list_regex  || ip =~ black_list_regex
    
    # Costruisco la regex per la validazione dei links
    links_match = description.scan(/http\:\/\/|www\./)
    errors.add_to_base("Il tuo messaggio contiene troppi link!") if links_match.size > Setting.first.spam_max_links
    
  end
  
private
  
  def deliver_notification
    Notifier.deliver_comment(self)
  end
  
end
