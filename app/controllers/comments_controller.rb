class CommentsController < ApplicationController           
     
    def index
      @comments = Comment.paginate(:page => params[:page], :per_page => 20)

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @comments }
      end
    end  
    
    def show
      @comment = Comment.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @comment }
      end
    end

  def new   
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create                      
    @community = Community.find_by_id(session[:community_id])       
    @comment = @community.comments.build(params[:comment])  
    @comment.username = current_user.username

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @community, notice: 'Community was successfully created.' }
        format.json { render json: @community, status: :created, location: @community }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:community])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to communities_url }
      format.json { head :ok }
    end
  end 
end