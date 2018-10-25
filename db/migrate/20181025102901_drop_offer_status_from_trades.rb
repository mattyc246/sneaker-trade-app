class DropOfferStatusFromTrades < ActiveRecord::Migration[5.2]
  def change
  	remove_column :trades, :offer_status
  end
end
