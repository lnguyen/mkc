class Community < ActiveRecord::Base    
  attr_accessible :code, :name, :region, :race_type, :items_type, :description, :view 
  
  belongs_to :user 
  
  has_many :comments, :dependent => :destroy     
  has_and_belongs_to_many :members, :class_name => 'User'
  
  
    HUMANIZED_ATTRIBUTES = {
    :code => "Community Code"
  }                         
  
  def self.human_attribute_name(attr)  
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end   
  
  code_regex = /\d{2}-\d{4}-\d{4}-\d{4}$/ 
  
                 
  validates_presence_of :name, :items_type, :race_type, :view                        
  validates :code, :presence   => true,
                   :format     => { :with => code_regex, :message => "must be in 12-3456-7890-1234 format"},        
                   :uniqueness => { :case_sensitive => false }
  
  def self.search(search)
    if search
      where('name like ?', "%#{search}%")
    else                                 
      scoped
    end
  end 
  
  def is_member?(user)
    return self.members.include? user 
    
  end  
  
end
