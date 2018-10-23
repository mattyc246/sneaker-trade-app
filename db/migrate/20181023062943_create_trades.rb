class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.belongs_to :user
      t.belongs_to :posting
      t.string :offer
      t.boolean :offer_status
      t.timestamps
    end
  end
end
