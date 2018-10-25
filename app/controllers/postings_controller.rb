class PostingsController < ApplicationController

	def new

	end

	def show

		@posting = Posting.find(params[:id])

	end

	def index

		if params[:search]

			@postings = Posting.search_title(params[:search])

		else

			@postings = Posting.all

		end

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

	def destroy

		posting = Posting.find(params[:id])

		if posting.destroy

			flash[:notice] = "You have successfully removed the post!"
			redirect_to user_path(current_user.id)

		else

			flash[:notice] = "It is not possible to remove the listing! If problems persist, contact the administrator!"
			redirect_to posting_path(posting.id)

		end

	end

	def update

		posting = Posting.find(params[:id])

		if posting.update(posting_params)

			flash[:notice] = "You have successfully updated your post!"
			redirect_to posting_path(posting.id)

		else

			flash[:notice] = "Unable to update the post! Please check the details and try again!"
			redirect_to posting_path(posting.id)

		end

	end


	private

	def posting_params

		params.require(:posting).permit(:title, :brand, :sneaker_type, :style, :size, :color, :condition, :expected_offer, {photos: []}, :search)

	end

end
