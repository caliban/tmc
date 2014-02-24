require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_title(user.first_name) }
    it { should have_content(user.first_name) }
  end
  
  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end
  
  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before { valid_signup }
      # before do
      #   fill_in "First Name",     with: "Example"
      #   fill_in "Last Name",      with: "User"
      #   fill_in "Email",          with: "user@example.com"
      #   fill_in "Gender",         with: "male"
      #   fill_in "Date of Birth",  with: "01/12/2012"
      #   fill_in "Password",       with: "foobarfoobar"
      #   fill_in "Password Confirmation",  with: "foobarfoobar"
      # end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'first.last@tmc.com') }
        
        it { should have_link('Log out') }
        it { should have_title(user.first_name) }
        # it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_success_message('Welcome') }
      end
    end
  end
end
