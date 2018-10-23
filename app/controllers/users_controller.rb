class UsersController < ApplicationController

	def index

	end

	def update

	end

	def delete

	end

	def sign_up

		user = User.new()

	end

	def sign_in

		user = User.find(params[:email])

		if params[:password] == user.password

			session[:user_id] = user.id
			flash[:notice] = "Successfully Logged In!"
			redirect_to root_path

		end

	end

	private

	def user_params

		params.require(:user).permit(:first_name,:last_name,:email,:password,:address,:city,:state,:postcode,:country,:phone_number,:photo)

	end

end
