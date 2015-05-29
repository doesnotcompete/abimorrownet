class AnswersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :ensure_admin!
  
  def index
    @question = Question.find(params[:question_id])
    @answers = @question.answers
  end
  
  def show
    @answer = Answer.find(params[:id])
  end
  
  def ensure_admin!
    unless current_user.admin?
      raise Pundit::NotAuthorizedError
      return
    end
  end
end
