class AddPhotosToPostings < ActiveRecord::Migration[5.2]
  def change
  	add_column :postings, :photos, :json
  end
end
