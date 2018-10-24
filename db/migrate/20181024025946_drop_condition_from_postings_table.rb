class DropConditionFromPostingsTable < ActiveRecord::Migration[5.2]
  def change
  	remove_column :postings, :condition
  end
end
