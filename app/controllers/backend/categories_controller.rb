class Backend::CategoriesController < BackendController

  def index
    params[:limit] ||= 50
    
    @column_store = column_store_for Category do |cm|
      cm.add :name
      cm.add :posts_count, :align    => :center
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

  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_parent_to(:action => "index")
    else
      render_to_parent(:action => "new")
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])    
    if @category.update_attributes(params[:category])
      redirect_parent_to(:action => "index")
    else
      render_to_parent(:action => "edit")
    end 
  end
  
  # Add in your model before_destroy and if the callback returns false, 
  # all the later callbacks and the associated action are cancelled.
  def destroy
    if Category.find(params[:id]).destroy
      render :json => { :success => true } 
    else
      render :json => { :success => false, :msg => I18n.t("backend.general.cantDelete") }
    end
  end
end