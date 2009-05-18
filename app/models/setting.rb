class Setting < ActiveRecord::Base
  
  # Validations
  validates_presence_of     :name,     :website, :suffix
  validates_numericality_of :menus,    :page_limit, :feed_limit, :spam_max_links
  validates_length_of       :email,    :within => 3..100
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of       :website,  :with => /\Ahttp\:\/\//
  
  
  def self.menu_range
    n = Setting.first.menus.to_i rescue 0
    (0..n)
  end
  
end
