class UsersController < ApplicationController

	def index

	end

	def create

		user = User.new(user_params)

		if user.save

			redirect_to root_path

		else

			redirect_to sign_up_path

		end

	end

	def show

		@user = User.find(params[:id])

	end

	def update

		user = User.find(params[:id])

		if user.update(user_params)

			flash[:notice] = "Successully updated details!"
			redirect_to user_path(user.id)

		else

			flash[:notice] = "Check the details you have provided are correct! Otherwise please contact the administrator!"
			redirect_to root_path

		end

	end

	def destroy

		user = User.find(params[:id])

		if user.destroy

			flash[:notice] = "Your account was Successfully removed! We're sorry to see you go =("
			session[:user_id] = nil
			redirect_to root_path

		else

			flash[:notice] = "Something went wrong! Check with the administrator if you have permission to do this!"
			redirect_to user_path(user.id)

		end

	end

	def sign_up


	end

	def sign_in

	end

	def sign_out

		session[:user_id] = nil
		redirect_to root_path

	end

	def login

		if user = User.find_by(email: user_params[:email])

			if user.authenticate(user_params[:password])

				session[:user_id] = user.id
				flash[:notice] = "Successfully Logged In!"
				redirect_to root_path

			else

				redirect_to sign_in_path

			end

		end

	end

	private

	def user_params

		params.require(:user).permit(:first_name,:last_name,:email,:password,:address,:city,:state,:postcode,:country,:phone_number,:photo)

	end

end
