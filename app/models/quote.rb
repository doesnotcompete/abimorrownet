class Quote < ActiveRecord::Base
  belongs_to :quotable, polymorphic: true
end
