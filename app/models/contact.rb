class Contact < Lipsiadmin::DataBase::WithoutTable
  column :name,        :string
  column :email,       :string
  column :description, :text  
  column :ip,          :string
  
  validates_presence_of :name,  :description
  validates_format_of   :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  def send_mail
    Notifier.deliver_contact(self) if valid?
    return valid?
  end
end