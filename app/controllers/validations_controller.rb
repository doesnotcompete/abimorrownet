class ValidationsController < ApplicationController
  before_filter :get_token, except: [:access_tokens, :create_single_token]
  before_filter :check_validity, except: [:invalid, :fatal_error, :access_tokens, :create_single_token]
  
  respond_to :html, :json
  
  def index
    @profile = @token.profile
    
    respond_to do |wants|
      wants.html # index.html.erb
    end
  end
  
  def comments
    @comments = @token.profile.profileable.quotes
    @profile = @token.profile
    
    @locked_count = 0
    @comments.each do |comment|
      if comment.locked then @locked_count += 1 end
    end
  end
  
  def contents
    @contents = @token.profile.contents
  end
  
  def questions
    if @token.profile.profileable_type == "Teacher" then
      @questions = Question.where(teacher: true)
    else
      @questions = Question.where(teacher: false)
    end
  end
  
  def new_answer
    @question = Question.find(params[:question_id])
    @answer = Answer.new(question: @question, profile: @token.profile)
  end
  
  def create_answer
    @question = Question.find(params[:question_id])
    @answer = Answer.create(question: @question, profile: @token.profile, text: params[:answer][:text], file: params[:answer][:file])
    
    redirect_to validate_questions_path(@token.token)
  end
  
  def edit_answer
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
    return unless @answer.profile = @token.profile || (current_user.admin? rescue true)
  end
  
  def update_answer
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
    return unless @answer.profile = @token.profile || (current_user.admin? rescue true)
    
    @answer.update(question: @question, profile: @token.profile, text: params[:answer][:text], file: params[:answer][:file])
  end
  
  def lock_comment
    comment = Quote.find(params[:comment_id])
    
    if comment.quotable == @token.profile.profileable || comment.quotable == @token.profile
      comment.locked = !comment.locked
      comment.save!
    else
      redirect_to validate_comments_path(params[:token]), notice: "Nicht berechtigt."
      return
    end
    
    if comment.persisted?
      redirect_to validate_comments_path(params[:token]), notice: "Kommentarstatus geändert."
    else
      redirect_to validation_error_path(params[:token])
    end
  end
  
  def report_content
    @content = Content.find(params[:content_id])
    
    @report = ContentProblem.new
    
    @reason_list = ["Ich möchte Details hinzufügen",
      "Verstoß gegen Ziffer 1 - Wahrhaftigkeit und Achtung der Menschenwürde",
      "Verstoß gegen Ziffer 2 – Sorgfalt",
      "Verstoß gegen Ziffer 4 – Grenzen der Recherche",
      "Verstoß gegen Ziffer 5 – Berufsgeheimnis",
      "Verstoß gegen Ziffer 7 – Trennung von Werbung und Redaktion",
      "Verstoß gegen Ziffer 8 – Schutz der Persönlichkeit",
      "Verstoß gegen Ziffer 9 – Schutz der Ehre",
      "Verstoß gegen Ziffer 10 – Religion, Weltanschauung, Sitte",
      "Verstoß gegen Ziffer 11 – Sensationsberichterstattung, Jugendschutz",
      "Verstoß gegen Ziffer 12 – Diskriminierungen",
      "Verstoß gegen Ziffer 13 – Unschuldsvermutung",
      "Verstoß gegen Ziffer 14 – Medizin-Berichterstattung",
      "Das Zitat ist nicht authentisch.",
      "Sonstiger Grund (bitte erläutern)"]
  end
  
  def create_report
    @content = Content.find(params[:content_id])
    
    ContentProblem.create(reason: params[:content_problem][:reason], description: params[:content_problem][:description], profile: @token.profile, content: @content)
    
    redirect_to validate_contents_path(@token.token)
  end
  
  def access_tokens
    authenticate_user!
    ensure_profile!
    
    @tokens = AccessToken.where(profile: current_user.profile) unless current_user.admin?
    @tokens = AccessToken.all if current_user.admin?
    
    @token = AccessToken.new
  end
  
  def create_single_token
    authenticate_user!
    ensure_profile!
    return unless current_user.admin?
    
    @profile = Profile.find(params[:access_token][:profile])
    
    AccessToken.generateFor(@profile, true)
    redirect_to access_tokens_path
  end
  
  def wrong_identity
    @profile = @token.profile
  end
  
  def change_name
    @profile = @token.profile
    @profile.update(first_name: params[:profile][:first_name], last_name: params[:profile][:last_name])
    redirect_to main_validations_path(@token.token), notice: "Name aktualisiert."
  end
  
  def fatal_error
    @profile = @token.profile if @token
  end
  
  def final
    @token.final = true
    @token.save
    
    @profile = @token.profile
    
    @comments = @token.profile.profileable.quotes
    
    @locked_count = 0
    @comments.each do |comment|
      if comment.locked then @locked_count += 1 end
    end 
    
    @contents = @token.profile.contents
    @reported_count = @profile.content_problems.count
    
    @answers = Answer.where(profile: @profile)
    
    if @token.profile.profileable_type == "Teacher" then
      @questions = Question.where(teacher: true)
    else
      @questions = Question.where(teacher: false)
    end
    
    @unanswered_count = 0

    @questions.each do |question|
      if question.answers.where(profile: @profile).empty? then @unanswered_count += 1 end
    end 
    
    @orders = Order.where("name ILIKE ?", @profile.full_name)
  end
  
  def preview
  end
  
  def quick_order
    # dirty
    
    @profile = @token.profile
    
    Order.create(products: [Product.find_by(price: 10)], email: @profile.profileable.email, name: @profile.full_name, description: "Expressbestellung")
    
    redirect_to validation_final_path(@token.token)
  end
  
  def invalid
  end
  
  def get_token
    @token = AccessToken.find_by(token: params[:token])
    session[:validation_token] = @token.token
    session[:comment_edit_redirect_to_validations] = true
  end
  
  def check_validity
    unless @token
      redirect_to validation_error_path(0)
      return
    end
    redirect_to invalid_token_path(@token.token) unless @token.is_valid?
  end
    
end
