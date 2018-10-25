class AddOfferStatusToTrades < ActiveRecord::Migration[5.2]
  def change
  	add_column :trades, :offer_status, :string
  end
end
