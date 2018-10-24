class AddSneakerTypeToPostingsTable < ActiveRecord::Migration[5.2]
  def change
  	add_column :postings, :sneaker_type, :string
  end
end
