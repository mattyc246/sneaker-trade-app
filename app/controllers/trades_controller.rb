class TradesController < ApplicationController

	def new

		@posting = Posting.find(params[:posting_id])

	end	

	def create

		posting = Posting.find(params[:posting_id])

		trade = Trade.new(trade_params)

		trade.user_id = current_user.id

		trade.posting_id = posting.id

		if trade.save

			flash[:notice] = "You have successfully made an offer on #{posting.title}"
			redirect_to user_trades_path

		else

			flash[:notice] = "Unable to make a trade offer! If problems persist contact the administrator!"
			redirect_to new_posting_trades_path(posting.id)

		end

	end

	def show

		@trades = Trade.where(posting_id: params[:posting_id])

	end

	def view_all

		@trades = Trade.where(user_id: current_user.id)
		@postings = Posting.where(user_id: current_user.id)

	end

	private

	def trade_params

		params.require(:trade).permit(:offer, :offer_status, :posting_id)

	end

end
