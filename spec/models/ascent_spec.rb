require 'spec_helper'

describe Ascent do
  
  let(:user)    { FactoryGirl.create(:user) }
  let(:climb)   { FactoryGirl.create(:climb) }
  let(:ascent)  { user.ascents.build(climb_id: climb.id, date: Time.now)}

  subject { ascent }
  
  it { should be_valid }
  
  describe "ascent methods" do
    it { should respond_to(:user) }
    it { should respond_to(:climb) }
    its(:user) { should eq user }
    its(:climb) { should eq climb }
  end

  describe "when user_id is not present" do
    before { ascent.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "when climb_id is not present" do
    before { ascent.climb_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank date" do
    before { ascent.date = " " }
    it { should_not be_valid }
  end
end
