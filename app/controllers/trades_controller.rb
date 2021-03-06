class TradesController < ApplicationController

	def new

		if logged_in?

			@posting = Posting.find(params[:posting_id])

		else

			redirect_to sign_in_path

		end

	end	

	def create

		if logged_in?

			posting = Posting.find(params[:posting_id])

			if current_user.id != posting.user.id

				trade = Trade.new(trade_params)

				trade.user_id = current_user.id

				trade.posting_id = posting.id

				if trade.save

					flash[:success] = "You have successfully made an offer on #{posting.title}"
					Twilio::REST::Client.new.messages.create({
					from: ENV['twilio_phone_number'],
					to: '+60176068669',
					body: "Someone has made an offer on your '#{posting.title}'. To view now, go to: https://shrade.herokuapp.com/postings/#{posting.id} "
					})
					redirect_to user_trades_path

				else

					flash[:danger] = "Unable to make a trade offer! If problems persist contact the administrator!"
					redirect_to new_posting_trades_path(posting.id)

				end

			else

				flash[:danger] = "You can't trade with yourself!"
				redirect_to new_posting_trades_path(posting.id)

			end

		else

			redirect_to sign_in_path

		end

	end

	def destroy

		if logged_in?

			trade = Trade.find(params[:trade_id])

			if superadmin? || current_user.id == trade.user_id

				if trade.destroy

					flash[:success] = "You have successfully retracted your offer!"
					redirect_to user_trades_path

				else

					flash[:danger] = "Unable to retract offer! If problems persist, contact administrator!"
					redirect_to user_trades_path

				end

			else

				flash[:danger] = "You are not authorized to do that!"
				redirect_to user_trades_path

			end

		else

			redirect_to sign_in_path

		end

	end

	def show

		if logged_in?

			@trades = Trade.where(posting_id: params[:posting_id])

		else

			redirect_to sign_in_path

		end


	end

	def view_all

		if logged_in?

			@trades = Trade.where(user_id: current_user.id)
			@postings = Posting.where(user_id: current_user.id)

		else

			redirect_to sign_in_path

		end

	end

	def accept_trade

		if logged_in?

			trade = Trade.find(params[:trade_id])
			
			if current_user.id != trade.user_id || superadmin?

				if trade.offer_status == 'pending'

					trade.accept
					flash[:success] = "You have accepted the offer! Congratulations!"
					Twilio::REST::Client.new.messages.create({
					from: ENV['twilio_phone_number'],
					to: '+60176068669',
					body: "#{current_user.first_name} has accepted your offer for #{trade.posting.title}! You can now arrange with the buyer to make the trade!"
					})
					render :json => {newStatus: trade.offer_status}

				else

					flash[:danger] = "This trade has already been accepted!"

				end

			else

				flash[:danger] = "You are not authorized to do this!"

			end

		else

			redirect_to sign_in_path

		end

	end

	def decline_trade

		if logged_in?

			trade = Trade.find(params[:trade_id])

			if current_user.id != trade.user_id || superadmin?

				if trade.offer_status == 'pending'

					trade.decline
					flash[:success] = "You have declined the offer!"
					Twilio::REST::Client.new.messages.create({
					from: ENV['twilio_phone_number'],
					to: '+60176068669',
					body: "#{current_user.first_name} has declined your offer for #{trade.posting.title}! Make another offer!"
					})
					render :json => {newStatus: trade.offer_status}

				else

					flash[:danger] = "This trade has already been accepted!"

				end

			else

				flash[:danger] = "You are not authorized to do that!"

			end

		else

			redirect_to sign_in_path

		end

	end

	private

	def trade_params

		params.require(:trade).permit(:offer, :offer_status, :posting_id)

	end

end
