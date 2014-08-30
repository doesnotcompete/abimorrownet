class TeachersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!

  respond_to :html, :json

  def index
    @teachers = Teacher.all

    respond_to do |format|
      format.html
      format.json { render json: TeacherDatatable.new(view_context) }
    end
  end

  def create
    authorize :teacher, :create?

    if @teacher = Teacher.create(teacher_params)
      redirect_to @teacher
    else
      render :edit
    end
  end

  def new
    authorize :teacher, :create?
  end

  def edit
    @teacher = find_friendly(Teacher)
  end

  def update
    @teacher = find_friendly(Teacher)
    authorize @teacher

    if @teacher.update(teacher_params)
      redirect_to @teacher
    else
      render :edit
    end
  end

  def show
    @teacher = find_friendly(Teacher)
    @quotes = @teacher.quotes
    respond_with @teacher
  end

  private

  def teacher_params
    params.require(:teacher).permit(:email, :first_name, :last_name)
  end
end
