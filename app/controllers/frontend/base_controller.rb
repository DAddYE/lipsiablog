class Frontend::BaseController < FrontendController

  def index
    params[:start] = 0
  end
  
  def category
    @category = Category.find_by_id(params[:id])
    render :action => :index
  end
  
  def page
    render :action => :index
  end
  
  def post
    @post = Post.publics.find_by_id(params[:id])
    @comment = @post.comments.build if @post
  end
  
  def static
    post
    render :action => :post
  end
  
  def search
    if params[:query].size < 3
      flash[:search] = "Digit at least 4 letters"
      redirect_to :action => :index
    else
      flash[:search] = "Result wose <strong class=\"highlight\">highlighted</strong>"
      redirect_to :action => :index, :query => params[:query]
    end
  end
  
  def contact
    params[:contact] ||= {}
    @contact = Contact.new(params[:contact].merge(:ip=>request.ip))
    return unless request.post?
    
    if @contact.send_mail
      flash[:ok] = "Mail Sended!<p>Thanks for contact us!</p>"
      flash[:warning] = nil
      @contact = Contact.new
      redirect_to :action => :contact
    else
      flash[:ok] = nil
      flash[:warning] = "Your mail was not sended because: <br />#{@contact.errors.full_messages.join(", ")}"
    end
  end
  
  def moved_post
    query = params[:old].last.gsub(/-/, "%")
    @post = Post.publics.search(:fields => "name", :query => query).first
    redirect_to @template.post_path(@post), :status => 301 
  rescue
    redirect_to :action => :index, :status => 301
  end
  
  def add_comment
    @post = Post.find_by_id(params[:id])
    
    # Controllo che ci sia il post di riferimento
    # e che la richiesta sia un post
    if !@post || !request.post?
      render(:text => "Not allowed", :status => :not_allowed)
      return
    end
    
    # Aggiungo l'ip
    @comment = @post.comments.build(params[:comment].merge(:ip => request.ip))
    
    # Salvo il commento
    if @comment.save
      flash[:warning] = nil
      redirect_to @template.post_path(@post).merge(:anchor => :form)
    else
      flash[:warning] = "Comment not published because: <br />#{@comment.errors.full_messages.join(", ")}"
      render  :action => :post
    end
  end
end