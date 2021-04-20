class ApplicationController < ActionController::Base
  def authenticate_user
    authenticate_user!
  end
end
