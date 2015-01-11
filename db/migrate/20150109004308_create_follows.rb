class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :user
      t.integer :following_id

      t.timestamps
    end
  end
end
