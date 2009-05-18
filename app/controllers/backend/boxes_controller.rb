class Backend::BoxesController < BackendController

  def index
    params[:limit] ||= 50
    
    @column_store = column_store_for Box do |cm|
      cm.add :name
      cm.add :position, :align => :center, :editor => { :xtype => :numberfield, :allowDecimals => false, :allowNegative => false, :allowBlank => false }
    end
    
    respond_to do |format|
      format.js 
      format.json do
        render :json => @column_store.store_data(params)
      end
    end
  end
  
  def new
    @box = Box.new
  end

  def create
    @box = Box.new(params[:box])
    if @box.save
      redirect_parent_to(:action => "edit", :id => @box)
    else
      render_to_parent(:action => "new")
    end
  end

  def edit
    @box = Box.find(params[:id])
  end

  def update
    @box = Box.find(params[:id])    
    if @box.update_attributes(params[:box])
      redirect_parent_to(:action => "edit", :id => @box)
    else
      render_to_parent(:action => "edit")
    end 
  end
  
  # Add in your model before_destroy and if the callback returns false, 
  # all the later callbacks and the associated action are cancelled.
  def destroy
    if Box.find(params[:id]).destroy
      render :json => { :success => true } 
    else
      render :json => { :success => false, :msg => I18n.t("backend.general.cantDelete") }
    end
  end
end