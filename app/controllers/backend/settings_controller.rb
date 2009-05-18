class Backend::SettingsController < BackendController

  def index
    @setting = Setting.first
  end

  def update
    @setting = Setting.first
    if @setting.update_attributes(params[:setting])
      redirect_parent_to(:action => "index", :id => @setting)
    else
      render_to_parent(:action => "index")
    end 
  end
  
end