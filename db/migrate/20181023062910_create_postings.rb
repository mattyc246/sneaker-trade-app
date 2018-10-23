class CreatePostings < ActiveRecord::Migration[5.2]
  def change
    create_table :postings do |t|
      t.string :title
      t.string :brand
      t.string :type
      t.string :style
      t.integer :size
      t.string :color
      t.integer :condition
      t.string :expected_offer
      t.belongs_to :user
      t.string :photos
      t.timestamps
    end
  end
end

