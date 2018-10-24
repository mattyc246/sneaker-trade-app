class DropTypeFromPostingsTable < ActiveRecord::Migration[5.2]
  def change
  	remove_column :postings, :type
  end
end
