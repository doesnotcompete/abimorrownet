class ValidationsController < ApplicationController
  respond_to :html, :json
  
  def index
    @token = AccessToken.find_by(token: params[:token])
    @profile = @token.profile
    
    respond_to do |wants|
      wants.html # index.html.erb
    end
  end
  
  def comments
    @token = AccessToken.find_by(token: params[:token])
    @comments = @token.profile.profileable.quotes
    
    @locked_count = 0
    @comments.each do |comment|
      if comment.locked then @locked_count += 1 end
    end
  end
  
  def contents
    @token = AccessToken.find_by(token: params[:token])
    @contents = @token.profile.contents
  end
  
  def lock_comment
    comment = Quote.find(params[:comment_id])
    comment.locked = !comment.locked
    comment.save!
    
    if comment.persisted?
      redirect_to validate_comments_path(params[:token]), notice: "Kommentarstatus geändert."
    else
      redirect_to validation_error_path(params[:token])
    end
  end
  
  def report_content
    @token = AccessToken.find_by(token: params[:token])
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
    @token = AccessToken.find_by(token: params[:token])
    @content = Content.find(params[:content_id])
    
    ContentProblem.create(reason: params[:content_problem][:reason], description: params[:content_problem][:description], email: params[:content_problem][:email], content: @content)
    
    redirect_to validate_contents_path(@token.token)
  end
  
  def access_tokens
    @tokens = AccessToken.where(profile: current_user.profile)
  end
  
  def wrong_identity
    @token = AccessToken.find_by(token: params[:token])
    @profile = @token.profile
  end
  
  def fatal_error
    @token = AccessToken.find_by(token: params[:token])
    @profile = @token.profile
  end
  
  def final
    @token = AccessToken.find_by(token: params[:token])
    @profile = @token.profile
    
    @comments = @token.profile.profileable.quotes
    
    @locked_count = 0
    @comments.each do |comment|
      if comment.locked then @locked_count += 1 end
    end 
    
    @contents = @token.profile.contents
    @orders = Order.where("name ILIKE ?", @profile.full_name)
  end
  
  def quick_order
    # dirty
    
    @token = AccessToken.find_by(token: params[:token])
    @profile = @token.profile
    
    Order.create(products: [Product.find_by(price: 10)], email: @profile.profileable.email, name: @profile.full_name, description: "Expressbestellung")
    
    redirect_to validation_final_path(@token.token)
  end
    
end
