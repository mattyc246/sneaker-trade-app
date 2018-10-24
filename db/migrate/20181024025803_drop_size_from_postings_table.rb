class DropSizeFromPostingsTable < ActiveRecord::Migration[5.2]
  def change
  	remove_column :postings, :size
  end
end
