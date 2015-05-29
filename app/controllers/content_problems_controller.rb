class ContentProblemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :get_report
  before_filter :ensure_admin!
  
  def show
  end
  
  def accept
    @report.legit = true
    @report.processed = true
    @report.save
    
    NotificationMailer.delay.accept_report(@report)
    
    redirect_to @report
  end
  
  def prepare_rejection
    
  end
  
  def reject
    @report.legit = false
    @report.processed = true
    @report.save
    
    NotificationMailer.delay.reject_report(@report, params[:message])
    
    redirect_to @report
  end
  
  def get_report
    @report = ContentProblem.find(params[:id])
  end
  
  def ensure_admin!
    unless current_user.admin?
      raise Pundit::NotAuthorizedError
      return
    end
  end
end
