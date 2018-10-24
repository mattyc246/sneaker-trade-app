class PostingsController < ApplicationController

	def new

	end

	def index

		@postings = Posting.all

	end

	def create

		posting = Posting.new(posting_params)

		posting.user_id = current_user.id

		if posting.save

			flash[:notice] = 'You have succesfully posted some kicks for trade!'
			redirect_to postings_path

		else

			flash[:notice] = 'Check all details have been filled out correctly! If problems persist, please notify the admin!'
			redirect_to new_posting_path

		end

	end


	private

	def posting_params

		params.require(:posting).permit(:title, :brand, :sneaker_type, :style, :size, :color, :condition, :expected_offer, :photos)

	end

end
