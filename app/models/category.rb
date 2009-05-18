class Category < ActiveRecord::Base
  # Validations
  validates_presence_of   :name
  validates_uniqueness_of :name
  
  # Relations
  has_and_belongs_to_many :posts
  
  def to_param
    id.to_s + "-" + name.downcase.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/-+$/, '').gsub(/^-+$/, '')
  end
end
