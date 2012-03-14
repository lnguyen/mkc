class AddTextToCommunities < ActiveRecord::Migration
  def change
   change_column :communities, :description, :text
  end
end
