class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_teacher
    @current_teacher ||= current_user.teacher
  end
  helper_method :current_teacher
end
