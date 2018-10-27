class ApplicationController < ActionController::Base

	  helper_method :current_user, :logged_in?, :superadmin?

	  def current_user
	    @current_user ||= User.find_by(id: session[:user_id])
	  end

	  def logged_in?
	    current_user != nil
	  end

	  def superadmin?
	  	current_user.user_level == "superadmin"
	  end
	

end
