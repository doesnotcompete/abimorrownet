class VotingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
end
