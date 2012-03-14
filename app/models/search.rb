class Search < ActiveRecord::Base  
  def communities 
    @communities ||= find_communities
  end                                
  
private

  def find_communities   
    communities = Community.order(:name)   
    communities = communities.where("name like ?", "%#{name}%") if name.present?
    communities = communities.where(race_type: race_type) if race_type.present?
    communities = communities.where(items_type: item_type) if item_type.present?
    communities = communities.where(region: region) if region.present?
    communities
  end  
   
end
