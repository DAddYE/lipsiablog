class Backend::CommentsController < BackendController

  def index
    params[:limit] ||= 50
    
    @column_store = column_store_for Comment do |cm|
      cm.add :name
      cm.add "post.name",  :post_name
      cm.add :email
      cm.add :website
      cm.add :description
      cm.add :ip
      cm.add :spam,        :renderer => :boolean,  :editor => { :xtype => :checkbox }
      cm.add :created_at,  :renderer => :datetime, :align => :right 
      cm.add :updated_at,  :renderer => :datetime, :align => :right 
    end
    
    respond_to do |format|
      format.js 
      format.json do
        render :json => @column_store.store_data(params, :joins => :post)
      end
    end
  end

  
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_parent_to(:action => "edit", :id => @comment)
    else
      render_to_parent(:action => "new")
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])    
    if @comment.update_attributes(params[:comment])
      redirect_parent_to(:action => "edit", :id => @comment)
    else
      render_to_parent(:action => "edit")
    end 
  end
  
  # Add in your model before_destroy and if the callback returns false, 
  # all the later callbacks and the associated action are cancelled.
  def destroy
    if Comment.find(params[:id]).destroy
      render :json => { :success => true } 
    else
      render :json => { :success => false, :msg => I18n.t("backend.general.cantDelete") }
    end
  end
end