include ApplicationHelper

# def full_title(page_title)
#   base_title = "tmc"
#   if page_title.empty?
#     base_title
#   else
#     "#{base_title} | #{page_title}"
#   end
# end

def valid_login(user)
  fill_in "Email",    with: user.email.upcase
  fill_in "Password", with: user.password
  click_button "Log in"
end

def valid_signup
  fill_in "First Name",     with: "First"
  fill_in "Last Name",      with: "Last"
  fill_in "Email",          with: "first.last@tmc.com"
  fill_in "Gender",         with: "male"
  fill_in "Date of Birth",  with: "01/12/2012"
  fill_in "Password",       with: "foobarfoobar"
  fill_in "Password Confirmation",  with: "foobarfoobar"
end


RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end