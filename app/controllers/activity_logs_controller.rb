class ActivityLogsController < ApplicationController
  before_action :ensure_admin
  
  def index
    @activity_logs = ActivityLog.includes(:user)
                                .recent
                                .limit(100)
    
    # Filtros opcionales
    @activity_logs = @activity_logs.by_user(params[:user_id]) if params[:user_id].present?
    @activity_logs = @activity_logs.by_action(params[:action_filter]) if params[:action_filter].present?
    @activity_logs = @activity_logs.where('performed_at >= ?', params[:date_from]) if params[:date_from].present?
    @activity_logs = @activity_logs.where('performed_at <= ?', params[:date_to]) if params[:date_to].present?
    
    @users = User.order(:name, :email)
    @actions = ActivityLog::ACTIONS.keys
  end
  
  def show
    @activity_log = ActivityLog.find(params[:id])
  end
  
  private
  
  def ensure_admin
    redirect_to root_path, alert: 'Acceso denegado.' unless current_user&.admin?
  end
end