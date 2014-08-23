Given /^I have not signed in$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I have signed in$/ do
  email = 'kevin@quosh.net'
  password = 'test1234'
  create_user(email, password)

  sign_in(email, password)

end

Given(/^I haved signed in incorrectly$/) do
  create_user
  sign_in('kevin@quosh.net', 'test12345')
end

# ===

def create_user(email = 'kevin@quosh.net', password = 'test1234')
  @user = User.create!(:email => email, :password => password, :password_confirmation => password)
end

def sign_in(email, password)
  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Anmelden"
end
