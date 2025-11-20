class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # Require authentication for all actions
  before_action :authenticate_user!
  include ActivityTrackable
  
  # Log login activity
  def after_sign_in_path_for(resource)
    ActivityLog.log_activity(resource, 'login', nil, nil, request)
    root_path
  end
end
