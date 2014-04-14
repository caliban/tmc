require 'spec_helper'

describe "ClimbPages" do
  describe "index" do
    before { visit climbs_path }
    
    describe "pagination" do
    
      it { should have_selector('div.pagination') }
      
      it "should list all climbs" do
        Climb.paginate(page: 1) do |climb|
          expect(page).to have_selector('li', text: climb.name)
        end
      end
    end
  end
end
