class Teacher < ActiveRecord::Base
  has_one :group
  has_one :profile, as: :profileable
end
