class AddPrivateFromCommunities < ActiveRecord::Migration
  def change 
    remove_column :communities, :is_private  
    add_column :communities, :view, :string
  end
end
