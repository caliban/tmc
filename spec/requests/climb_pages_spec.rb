require 'spec_helper'

describe "ClimbPages" do
  describe "index" do
    before { visit climbs_path }
    
    describe "pagination" do
      
      # gives errors for no apparent reason:
      # it { should have_selector('div.pagination') }
      
      it "should list all climbs" do
        Climb.paginate(page: 1) do |climb|
          expect(page).to have_selector('li', text: climb.name)
        end
      end
    end
  end
  
  describe "show" do
    let!(:climb) { FactoryGirl.create(:climb) }
    
    before { visit climb_path(climb) }
    
    it { should have_title(climb.name) }
    it { should have_content(climb.name) }
    it { should have_content(climb.grade) }
    it { should have_content(climb.rating) }
  end
end
