class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :ensure_admin!
  
  def new
    @question = Question.new  
  end
  
  def index
    @questions = Question.all
  end
  
  def create
    @question = Question.create(question_params)
    
    redirect_to @question
  end
  
  def show
    @question = Question.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:id])
    
    @question.update(question_params)
    
    redirect_to @question
  end
  
  private

  def question_params
    params.require(:question).permit(:title, :description, :teacher, :fileAllowed)
  end
  
  def ensure_admin!
    unless current_user.admin?
      raise Pundit::NotAuthorizedError
      return
    end
  end
end
