class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable    
  
  
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username   
  
  has_and_belongs_to_many :communities  
  
  has_many :friendships 
  
  has_many :friends,
           :through    => :friendships,
           :conditions => "status = 'accepted'",
           :order => :username
           
  has_many :requested_friends,
           :through => :friendships,
           :source  => :friend,
           :conditions => "status = 'requested'",  
           :order => :username
           
  has_many :pending_friends,
           :through => :friendships,
           :source => :friend,
           :conditions => "status = 'pending'",
           :order => :username
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },        
                    :uniqueness => { :case_sensitive => false }
                    
  validates :username, :presence   => true,
                       :uniqueness => { :case_sensitive => false } 
 
 
  
                                                                     
  # ================
  # = Communities  =
  # ================  
                       
  def friends_communities
    communities = []
    self.friends.each do |friend|   
      friend.communities.each do |community|
        communities << community    
      end
    end  
    communities.uniq
  end       
  
  def viewable_communities
    communities = friends_communities + public_communities + private_communities
    communities.uniq
  end
  
  def public_communities
    communities = Community.all :conditions => { :view => 'Public' } 
  end                
  
  def private_communities
    communities = self.communities.where(:view => "Private")
  end     
  
  # ======================
  # = Omniauth functions =
  # ======================
                      
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.find_by_email(data.email)
      user
    else # Create a user with a stub password. 
      User.new
    end
  end
  
  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token.info   
    if user = User.find_by_email(data["email"])
      user
    else
      User.new
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|  
      if data = session["devise.facebook_data"]
        user.email = data["email"]
        user.password = Devise.friendly_token[0,20]  
      elsif data = session["devise.google_data"]
        user.email = data["email"]
        user.password = Devise.friendly_token[0,20] 
      end
    end
  end                                   
end
