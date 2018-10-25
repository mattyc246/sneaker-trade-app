class TradesController < ApplicationController

	def new

		@posting = Posting.find(params[:posting_id])

	end	

end
