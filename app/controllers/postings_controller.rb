class PostingsController < ApplicationController

	def new

		if logged_in?

		else

			redirect_to sign_in_path

		end

	end

	def show

		if logged_in?

			@posting = Posting.find(params[:id])

		else

			redirect_to sign_in_path

		end


	end

	def index

		if params[:search]

			@postings = Posting.search_title(params[:search])

		else

			@postings = Posting.all

		end

	end

	def create

		if logged_in?

			posting = Posting.new(posting_params)

			posting.user_id = current_user.id

			if posting.save

				flash[:success] = 'You have succesfully posted some kicks for trade!'
				redirect_to postings_path

			else

				flash[:danger] = 'Check all details have been filled out correctly! If problems persist, please notify the admin!'
				redirect_to new_posting_path

			end

		else

			redirect_to sign_in_path

		end

	end

	def destroy

		if logged_in?

			posting = Posting.find(params[:id])

			if current_user.id == posting.user_id || superadmin?

				if posting.destroy

					flash[:success] = "You have successfully removed the post!"
					redirect_to user_path(current_user.id)

				else

					flash[:danger] = "It is not possible to remove the listing! If problems persist, contact the administrator!"
					redirect_to posting_path(posting.id)

				end

			else

				flash[:danger] = "You are not authorized to do that!"
				redirect_to posting_path(posting.id)

			end

		else

			redirect_to sign_in_path

		end

	end

	def update

		if logged_in?

			posting = Posting.find(params[:id])

			if current_user.id == posting.user_id || superadmin?

				if posting.update(posting_params)

					flash[:success] = "You have successfully updated your post!"
					redirect_to posting_path(posting.id)

				else

					flash[:danger] = "Unable to update the post! Please check the details and try again!"
					redirect_to posting_path(posting.id)

				end

			else

				flash[:danger] = "You are not authorized to do that!"
				redirect_to posting_path(posting.id)

			end

		else

			redirect_to sign_in_path

		end

	end

	def keyword_search

		if params[:search] != ""

			@postings = Posting.search_title(params[:search])

			respond_to do |format|

				format.js { @postings }
				format.html { render 'postings/index' }

			end

		else

			@postings = Posting.all

			respond_to do |format|

				format.js { @postings }
				format.html { render 'postings/index' }

			end

		end

	end

	private

	def posting_params

		params.require(:posting).permit(:title, :brand, :sneaker_type, :style, :size, :color, :condition, :expected_offer, {photos: []}, :search)

	end

end
