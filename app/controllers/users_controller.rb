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

	end

	def delete

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
