class CommunitiesController < ApplicationController     
  include CommunitiesHelper  
  
  def join_community
    @community = Community.find_by_id(session[:community_id]) 
    @community.members << current_user    
    redirect_to @community     
  end 
  
  def leave_community    
    @community = Community.find_by_id(session[:community_id])                 
    @community.members.delete(current_user) 
    redirect_to @community
  end     
  
  # GET /communities
  # GET /communities.json
  def index 
    if user_signed_in?
      @communities = current_user.viewable_communities.paginate(:page => params[:page], :per_page => 20)      
    else
      @communities = Community.paginate(:page => params[:page], :per_page => 20, :conditions => { :view => "Public" }) 
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @communities }
    end
  end

  # GET /communities/1
  # GET /communities/1.json
  def show      
    @community = Community.find(params[:id]) 
    session[:community_id] = @community.id
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @community }
    end
  end

  # GET /communities/new
  # GET /communities/new.json
  def new
    @community = Community.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @community }
    end
  end

  # GET /communities/1/edit
  def edit
    @community = Community.find(params[:id])
  end

  # POST /communities
  # POST /communities.json
  def create     
                             
    @community = current_user.communities.create(params[:community])
    @community.user = current_user  
    

    respond_to do |format|
      if @community.save
        format.html { redirect_to @community, notice: 'Community was successfully created.' }
        format.json { render json: @community, status: :created, location: @community }
      else
        format.html { render action: "new" }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /communities/1
  # PUT /communities/1.json
  def update
    @community = Community.find(params[:id])

    respond_to do |format|
      if @community.update_attributes(params[:community])
        format.html { redirect_to @community, notice: 'Community was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end  
     

  # DELETE /communities/1
  # DELETE /communities/1.json
  def destroy                      
    @community = Community.find(params[:id])
    @community.destroy

    respond_to do |format|
      format.html { redirect_to communities_url }
      format.json { head :ok }
    end
  end
end
