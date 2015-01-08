class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.references :beer, index: true
      t.references :user, index: true
      t.text :comment

      t.timestamps
    end
  end
end
