require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "login page" do
    before { visit login_path }

    it { should have_content('Log in') }
    it { should have_title('Log in') }
  end
  
  describe "login" do
    before { visit login_path }
    
    describe "'remember me' checkbox" do
      it { should have_unchecked_field('Remember me') }
    end

    describe "with invalid information" do
      before { click_button "Log in" }

      it { should have_title('Log in') }
      # it { should have_selector('div.alert.alert-error') }
      it { should have_error_message('Invalid') }
      
      describe "after visiting another page" do
        before { click_link "tmc" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_login(user) }
      # before do
      #   fill_in "Email",    with: user.email.upcase
      #   fill_in "Password", with: user.password
      #   click_button "Log in"
      # end

      it { should have_title(user.first_name) }
      it { should have_link('Profile',    href: user_path(user)) }
      it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should have_link('Log out',    href: logout_path) }
      it { should_not have_link('Log in', href: login_path) }
      
      describe "followed by signout" do
        before { click_link "Log out" }
        it { should have_link('Log in') }
      end
    end
  end
  
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Log in"
        end

        describe "after logging in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Log in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(login_path) }
        end
      end
      
      describe "as wrong user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
        before { login user, no_capybara: true }

        describe "submitting a GET request to the Users#edit action" do
          before { get edit_user_path(wrong_user) }
          specify { expect(response.body).not_to match(full_title('Edit user')) }
          specify { expect(response).to redirect_to(root_url) }
        end

        describe "submitting a PATCH request to the Users#update action" do
          before { patch user_path(wrong_user) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end
    end
  end
end
