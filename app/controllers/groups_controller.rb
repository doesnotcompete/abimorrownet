class GroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  around_filter :catch_errors

  def index
    @groups = Group.all
  end

  def new
  end

  def create
    authorize :groups, :create?

    if @group = Group.create(group_params)
      redirect_to @group
    else
      redirect_to root_url, notice: "Fehler beim Erstellen."
    end
  end

  def show
    @group = find_group
  end

  def edit
    @group = find_group
  end

  def update
    @group = find_group
    authorize @group

    @group.assign_attributes(group_params)
    users = User.find(params[:group][:user_ids].reject! { |c| c.empty? })
    @group.users = users

    if @group.save
      redirect_to @group
    else
      render :edit
    end
  end

  def destroy
    @group = find_group

    authorize @group
    @group.destroy!
    redirect_to groups_url, notice: "Seminarfach gelöscht."
  end


  private

  def find_group
    Group.friendly.find(params[:id]) || Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:title, :description, :teacher_id)
  end

  def catch_errors
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, alert: "Seminarfach nicht gefunden."
  rescue Pundit::NotAuthorizedError
    redirect_to root_url, alert: "Nicht berechtigt."
  end
end
