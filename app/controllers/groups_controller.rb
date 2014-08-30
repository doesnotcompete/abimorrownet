class GroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!

  def index
    @groups = Group.includes(:teacher).all
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
    @group = find_friendly(Group)
  end

  def edit
    @group = find_friendly(Group)
  end

  def update
    @group = find_friendly(Group)
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
    @group = find_friendly(Group)

    authorize @group
    @group.destroy!
    redirect_to groups_url, notice: "Seminarfach gelöscht."
  end


  private

  def group_params
    params.require(:group).permit(:title, :description, :teacher_id)
  end
end
