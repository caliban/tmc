require 'spec_helper'

describe "StaticPages" do
  
  let(:base_title) {"tmc"}
  
  describe "Home page" do
    it "should have the content 'tmc'" do
      visit '/static_pages/home'
      expect(page).to have_content('tmc')
    end
    
    it "should have the base title" do
      visit '/static_pages/home'
      expect(page).to have_title("#{base_title}")
    end
    
    it "should not have a custom title" do
      visit '/static_pages/home'
      expect(page).not_to have_title("Home")
    end
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    
    it "should have the title 'tmc | Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("#{base_title} | Help")
    end
  end
end
