require 'spec_helper'

describe Climb do
  
  let(:climb)   { FactoryGirl.create(:climb) }
  
  subject { climb }

  it { should be_valid }
  
  describe "climb methods" do
    it { should respond_to(:name) }
    it { should respond_to(:grade) }
    it { should respond_to(:rating) }
    it { should respond_to(:ascents) }
    # its(:user) { should eq user }
    # its(:climb) { should eq climb }
  end
  
  describe "when name is wrong" do
    its (:name)  { should eq climb.name }
  end
  
  describe "when name is not present" do
    before { climb.name = nil }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { climb.name = "a"*51 }
    it { should_not be_valid }
  end
  
  describe "when grade is too long" do
    before { climb.grade = "a"*6 }
    it { should_not be_valid }
  end  
  
  describe "when rating is negativ" do
    before { climb.rating = "-1" }
    it { should_not be_valid }
  end
  
  describe "when rating is too high" do
    before { climb.rating = "5.6" }
    it { should_not be_valid }
  end
end
