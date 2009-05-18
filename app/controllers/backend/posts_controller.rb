class Backend::PostsController < BackendController

  def show
    params[:limit] ||= 50
    
    @column_store = column_store_for Post do |cm|
      cm.add :name
      cm.add :tags
      cm.add :position,       :align    => :center,   :editor => { :xtype => :numberfield, :allowDecimals => false, :allowNegative => false }
      cm.add :comments_count, :align    => :center
      cm.add :commentable,    :renderer => :boolean,  :align => :center, :renderer => :boolean,  :editor => { :xtype => :checkbox }
      cm.add :draft,          :renderer => :boolean,  :align => :center, :renderer => :boolean,  :editor => { :xtype => :checkbox }
      cm.add :created_at,     :renderer => :datetime, :align => :right 
      cm.add :updated_at,     :renderer => :datetime, :align => :right 
    end
    
    respond_to do |format|
      format.js 
      format.json do
        render :json => @column_store.store_data(params, :include => :comments, :conditions => "menu = #{params[:id]}")
      end
    end
  end

  
  def new
    @post = current_account.posts.build(:menu => params[:id].to_i)
  end

  def create
    @post = current_account.posts.build(params[:post])
    if @post.save
      redirect_parent_to(:action => "edit", :id => @post)
    else
      render_to_parent(:action => "new")
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])    
    if @post.update_attributes(params[:post])
      redirect_parent_to(:action => "edit", :id => @post)
    else
      render_to_parent(:action => "edit")
    end 
  end
  
  # Add in your model before_destroy and if the callback returns false, 
  # all the later callbacks and the associated action are cancelled.
  def destroy
    if Post.find(params[:id]).destroy
      render :json => { :success => true } 
    else
      render :json => { :success => false, :msg => I18n.t("backend.general.cantDelete") }
    end
  end
end