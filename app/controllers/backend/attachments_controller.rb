class Backend::AttachmentsController < BackendController

  def index
    params[:limit] ||= 50
    
    @column_store = column_store_for Attachment do |cm|
      cm.add :attached_file_name
      cm.add :attached_content_type, :align    => :center
      cm.add :attached_file_size, :renderer => "Ext.util.Format.fileSize".to_l, :align => :center
      cm.add :url, :hidden => true
      cm.add :created_at, :renderer => :datetime, :align => :right 
      cm.add :updated_at, :renderer => :datetime, :align => :right 
    end
    
    respond_to do |format|
      format.js 
      format.json do
        render :json => @column_store.store_data(params)
      end
    end
  end
  
  def show
    attachment = Attachment.find(params[:id])
    html = ""
    
    if attachment.attached_content_type.include?("image")
      thumb    = Lipsiadmin::Attachment::Thumbnail.new(attachment.file, :geometry => "540x380").make
      geometry = Lipsiadmin::Attachment::Geometry.from_file(thumb)
      style    = "height:#{geometry.height}px;width:#{geometry.width}px;"
      html     = "<div style='text-align:center;#{style}'><img src='#{attachment.url}' style='#{style}' /></div>"
    end
    
    html += "<div style='padding:10px;text-align:center;background-color:#FFF;font-size:13px'>#{attachment.url}</div>"
    
    # Now we can remove the thumb from our temp
    File.delete(thumb.path)
    
    render :text => html
  end

  def create
    if current_account.update_attributes(params[:account])
      redirect_parent_to(:action => "index")
    else
      render_to_parent(:action => "new")
    end
  end
  
  # Add in your model before_destroy and if the callback returns false, 
  # all the later callbacks and the associated action are cancelled.
  def destroy
    if Attachment.find(params[:id]).destroy
      render :json => { :success => true } 
    else
      render :json => { :success => false, :msg => I18n.t("backend.general.cantDelete") }
    end
  end
end