class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!

  def index

  end
end
