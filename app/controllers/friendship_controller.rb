class FriendshipController < ApplicationController 
  include FriendshipHelper        
  before_filter :setup_friends 
  
  
  def create                           
    Friendship.request(@user, @friend)
    flash[:notice] = "Friend request sent." 
    redirect_to user_path(@friend)
  end                  
  
  def accept
     if @user.requested_friends.include?(@friend) 
       Friendship.accept(@user, @friend)
       flash[:notice] = "Friendship with #{@friend.username} is accepted!"
     else
       flash[:notice] = "No friendship requested from #{@friend.username}."
     end
     redirect_to user_path(@user)
  end                     
  
  def decline
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.username} declined."
    else
      flash[:notice] = "No friendship requested from #{@friend.username}."
    end   
    redirect_to user_path(@user)
  end
  
  def cancel
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship request canceled"
    else
      flash[:notice] = "No request for friendship with #{@friend.username}."
    end 
    redirect_to user_path(@user)
  end 
  
  def delete
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.username} deleted."
    else
      flash[:notice] = "You aren't friends with #{@friend.username}."
    end
    redirect_to user_path(@user)
  end                                                  
 
  
  private
  
  def setup_friends   
    @user = current_user
    @friend = User.find_by_id(params[:id])
  end
end
