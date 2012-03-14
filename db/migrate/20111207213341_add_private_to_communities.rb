class AddPrivateToCommunities < ActiveRecord::Migration
  def change
    add_column :communities, :is_private, :boolean
  end
end
