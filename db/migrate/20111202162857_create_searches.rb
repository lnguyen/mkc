class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :name
      t.string :region
      t.string :race_type
      t.string :item_type

      t.timestamps
    end
  end
end
