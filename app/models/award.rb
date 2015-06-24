class Award < ActiveRecord::Base
  belongs_to :voting
  has_many :nominations, dependent: :destroy
  has_many :users, through: :nominations

  validates :title, :tiers, :voting, presence: true

  def self.export_all
    require 'csv'
    csv_path = "#{Rails.root}/export/awards.csv"

    #contents = Content.joins(:content_problems).where.not(content_problems: { legit: true }).includes(:content_associations)

    nominations = Nomination.includes(:award).includes(:user).where(accepted: true)

    CSV.open(csv_path, "wb") do |csv|
      csv << ["user_id", "user_first_name", "user_last_name", "tier", "award_id", "award_title"]
      nominations.each do |nomination|
        csv << [nomination.user_id, nomination.user.first_name, nomination.user.last_name, nomination.tier, nomination.award.id, nomination.award.title]
      end
    end
  end

end
