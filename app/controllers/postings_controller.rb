class PostingsController < ApplicationController

	def new

	end


	private

	def posting_params

		params.require(:posting).permit(:title, :brand, :type, :style, :size, :color, :condition, :expected_offer, :photos)

	end

end
