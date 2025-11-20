module ActivityTrackable
  extend ActiveSupport::Concern
  
  included do
    after_action :log_activity, if: :should_log_activity?
  end
  
  private
  
  def should_log_activity?
    return false unless current_user
    return false if request.format.json?
    return false if action_name == 'index'
    return false if controller_name == 'sessions' # Skip Devise sessions
    true
  end
  
  def log_activity
    return unless current_user
    return if request.format.json? # Skip API requests
    
    action = determine_action
    resource = determine_resource
    
    ActivityLog.log_activity(
      current_user,
      action,
      resource,
      nil,
      request
    )
  end
  
  def determine_action
    case action_name
    when 'show'
      'view'
    when 'create'
      'create'
    when 'update'
      'update'
    when 'destroy'
      'destroy'
    else
      action_name
    end
  end
  
  def determine_resource
    # Try to find the resource from instance variables
    controller_name_singular = controller_name.singularize
    instance_var = "@#{controller_name_singular}"
    
    if instance_variable_defined?(instance_var)
      instance_variable_get(instance_var)
    end
  end
end