module CommunitiesHelper        
  def join_community 
    @community.members << current_user         
  end 
  
  def leave_community               
    @community.members.delete(current_user)
  end     
end
