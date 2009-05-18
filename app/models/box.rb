class Box < ActiveRecord::Base
  
  # Validations
  validates_presence_of     :name, :description
  validates_numericality_of :position
  
  # Named Scope
  named_scope :ordered,     :order => "position DESC"
end
