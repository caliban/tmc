require 'spec_helper'

describe User do
  before { @user = User.new(first_name: "Example", last_name: "User", email: "user@example.com", gender: "male", date_of_birth: "20/12/1991", password: "foobarfoobar", password_confirmation: "foobarfoobar") }
  # before { @user = FactoryGirl.create(:user) }
  
  subject { @user }
  
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:gender) }
  it { should respond_to(:date_of_birth) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:ascents) }
  it { should respond_to(:climbs) }
  
  it { should be_valid }
  it { should_not be_admin }
  
  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end
  
  describe "when first name is not present" do
    before { @user.first_name = "" }
    it { should_not be_valid }
  end

  describe "when last name is not present" do
    before { @user.last_name = "" }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when gender is not present" do
    before { @user.gender = "" }
    it { should_not be_valid }
  end
  
  describe "when gender type is invalid" do
    it "should be invalid" do
      gender_type = %w[Male 0 none]
      gender_type.each do |invalid_gender_type|
        @user.gender = invalid_gender_type
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when date of birth is not present" do
    before { @user.date_of_birth = "" }
    it { should_not be_valid }
  end
  
  describe "when first_name is too long" do
    before { @user.first_name = "a" * 26 }
    it { should_not be_valid }
  end
  
  describe "when first_name format is invalid" do
    it "should be invalid" do
      first_names = %w[mike F MIchA -Dan Fred2]
      first_names.each do |invalid_first_name|
        @user.first_name = invalid_first_name
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when last_name is too long" do
    before { @user.last_name = "a" * 26 }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end
  
  describe "when password is not present" do
    before do
      @user.password = " "
      @user.password_confirmation = ""
    end
    it { should_not be_valid }
  end
  
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 9 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
  
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "climb association" do
    
    before { @user.save }
    let!(:climb) { FactoryGirl.create(:climb) }
    let!(:old_ascent) do
      FactoryGirl.create(:ascent, user: @user, climb: climb, created_at: 1.day.ago)
    end
    
    let!(:new_ascent) do
      FactoryGirl.create(:ascent, user: @user, climb: climb, created_at: 1.hour.ago)
    end
    
    it "should list ascents in correct order" do
      expect(@user.ascents.to_a).to eq [new_ascent, old_ascent]
    end
    
    it "should destroy associated ascents" do
      ascents = @user.ascents.to_a
      @user.destroy
      expect(ascents).not_to be_empty
      ascents.each do |ascent|
        expect(Ascent.where(id: ascent.id)).to be_empty
      end
    end
  end
end
