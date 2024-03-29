class UsersController < ApplicationController  
    def index      
      @users = User.paginate(:page => params[:page], :per_page => 20, :conditions => ['id not in (?)',current_user.id])

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    end  
    
    def show
      @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    end

  def new   
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create    
    email = session["email"]           
                   
    @user = User.create!(:email => email, :username => params[:username] )  
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Community was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end         
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:community])
        format.html { redirect_to @User, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end    
end
