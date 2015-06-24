class Content < ActiveRecord::Base
  belongs_to :user
  has_many :content_associations
  has_many :content_problems

  has_attached_file :file
  do_not_validate_attachment_file_type :file
  validates_attachment_size :file, :less_than => 10.megabytes

  validates :title, :kind, presence: true
  
  def self.export_all
    require 'csv'
    csv_path = "#{Rails.root}/export/contents.csv"
    
    #contents = Content.joins(:content_problems).where.not(content_problems: { legit: true }).includes(:content_associations)
    contents = Content.includes(:content_problems).includes(:content_associations).all

    CSV.open(csv_path, "wb") do |csv|
      csv << ["id", "title", "kind", "text", "associations", "problem", "legit", "reason", "description"]
      contents.each do |content|
        row = [content.id, content.title, content.kind, content.text]
        row << content.content_associations.map {|assoc| Profile.find(assoc.profile_id).full_name}
        row << content.content_problems.map {|p| true}
        row << content.content_problems.map {|p| p.legit}
        row << content.content_problems.map {|p| p.reason}
        row << content.content_problems.map {|p| p.description}
        csv << row
      end
    end
  end
end
