class CreateTableLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :beer
      t.references :user
      t.timestamps
    end
  end
end
