class DropPhotosFromPostings < ActiveRecord::Migration[5.2]
  def change
  	remove_column :postings, :photos
  end
end
