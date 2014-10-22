class ContentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!

  respond_to :html, :json

  def new
  end

  def create
    authorize :content, :create?

    @content = Content.new(content_params)
    @content.user = current_user

    if @content.save
      redirect_to content_complete_path
    else
      flash[:notice] = "Fehler beim Speichern. Bitte stelle sicher, dass alle erforderlichen Felder ausgefüllt sind. Dateien dürfen max. 5 MB groß sein. Möchtest du größere Dateien bereitstellen, kontaktiere uns."
      render :new
    end
  end

  def index
    authorize :content, :index?

    @contents = Content.all

    respond_to do |format|
      format.html
      format.json { render json: ContentDatatable.new(view_context) }
    end
  end

  def show
    authorize :content, :show?

    @content = Content.find(params[:id])
  end

  def edit
    if @content = Content.find(params[:id])
      authorize @content
    else
      redirect_to root_url, alert: "Inhalt nicht gefunden."
    end
  end

  def update
    @content = Content.find(params[:id])
    authorize @content

    if @content.update(content_params)
      redirect_to @content
    else
      render :edit
    end
  end

  def destroy
    @content = Content.find(params[:id])
    authorize @content

    if @content.destroy
      redirect_to contents_path, notice: "Inhalt gelöscht."
    else
      render :show
    end
  end

  def complete
    render :complete
  end

  private

  def content_params
    params.require(:content).permit(:title, :text, :kind, :file)
  end
end
