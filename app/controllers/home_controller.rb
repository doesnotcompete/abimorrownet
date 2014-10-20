class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!

  def index
    @pending_quotes = Quote.pending_overview(current_user)
    @quotes_pending |= @pending_quotes.present?

    @announcements = Announcement.dashboard
  end
end
