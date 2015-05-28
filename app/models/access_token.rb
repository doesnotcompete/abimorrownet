class AccessToken < ActiveRecord::Base
  belongs_to :profile
  
  def self.generateFor(target, notify)
    token = AccessToken.create(token: SecureRandom.hex(6), validUntil: 7.days.from_now, profile: target)
    
    if notify 
      puts "Notifying..."
      NotificationMailer.delay.access_token(token) 
    end
    return token
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
