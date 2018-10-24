class AddConditionToPostingsTable < ActiveRecord::Migration[5.2]
  def change
  	add_column :postings, :condition, :string
  end
end
