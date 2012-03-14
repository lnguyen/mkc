class ApplicationController < ActionController::Base
  protect_from_forgery    
  
private    

  def after_sign_out_path_for(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    send(:"root_path")
  end
end
