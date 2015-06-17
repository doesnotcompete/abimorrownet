class AccessToken < ActiveRecord::Base
  belongs_to :profile
  
  def self.generateFor(target, notify)
    existing_tokens = AccessToken.where(profile: target).where("\"validUntil\" > ?", Time.now)
    if existing_tokens.empty?
      token = AccessToken.create(token: SecureRandom.hex(6), validUntil: 7.days.from_now, profile: target)
    
      if notify 
        puts "Notifying..."
      
        if target.profileable_type == "User"
          NotificationMailer.delay.access_token_student(token)
        else
          NotificationMailer.delay.access_token(token)
        end
      end
      return token
    end
  end
  
  def self.generateForAll(notify)
    Profile.all.each do |profile|
      AccessToken.generateFor(profile, notify)
    end
  end
  
  def is_valid? 
    return validUntil > Time.now
  end
end
