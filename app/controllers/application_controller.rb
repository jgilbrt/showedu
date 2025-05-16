class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Permit the `username` field along with other fields for sign up and account update
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  # in app/controllers/application_controller.rb
def after_sign_out_path_for(resource_or_scope)
  new_user_session_path
end

end
