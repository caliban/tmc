require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do
    it "should have the content 'tmc'" do
      visit '/static_pages/home'
      expect(page).to have_content('tmc')
    end
    
    it "should have the title 'tmc | Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("tmc | Home")
    end
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    
    it "should have the title 'tmc | Help'" do
      visit '/static_pages/home'
      expect(page).to have_title("tmc | Help")
    end
  end
end
