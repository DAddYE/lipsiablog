class Attachment < Lipsiadmin::DataBase::AttachmentTable
  include Lipsiadmin::DataBase::UtilityScopes
  validates_attachment_presence
  # attachment_styles :thumb, "128x128"
  
  # It's used from xmlrpc api for check or build a temp file
  def self.get_temp_file(up, name)
    if up.kind_of?(Tempfile) && !up.local_path.nil? && File.exist?(up.local_path)
      return up
    else
      bytes = up
      if up.kind_of?(StringIO)
        up.rewind
        bytes = up.read
      end
      File.open("#{Rails.root}/tmp/#{name}", "wb") { |f| f.write(bytes) }
      return File.open("#{Rails.root}/tmp/#{name}")
    end
  end
  
  def self.clear_temp_file(name)
    File.delete("#{Rails.root}/tmp/#{name}")
  end
end