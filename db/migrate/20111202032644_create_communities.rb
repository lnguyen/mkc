class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name
      t.string :region
      t.string :code
      t.string :race_type
      t.string :items_type

      t.timestamps
    end
  end
end
