class AddSizeToPostingsTable < ActiveRecord::Migration[5.2]
  def change
  	add_column :postings, :size, :string
  end
end
