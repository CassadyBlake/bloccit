require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: "Bloccit User", email: "user@gmail.com", password: "password") }

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@gmail.com").for(:email) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: "Bloccit User", email: "user@gmail.com")
    end

    it "should format name" do
      user.name = "mike greenlee"
      user.save
      expect(user.name).to eq ("Mike Greenlee")
    end

    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end

    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end
  end

  describe "roles" do
    it "is member by default" do
      expect(user.role).to eql("member")
    end

    context "member user" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end

  describe "invalid user" do
    let(:user_with_invalid_name) { User.new(name: "", email: "user@gmail.com", password: "abc123") }
    let(:user_with_invalid_email) { User.new(name: "Bloccit User", email: "", password: "abc123") }

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  describe "format user names" do
    let(:non_formatted_user) { User.new(name: "mike greenlee", email: "mike@gmail.com", password: "abc123") }
    let(:already_formatted_user) { User.new(name: "Mark GreeNtree", email: "mike@gmail.com", password: "abc123") }

    it "should format un-formatted name to be capitalized" do
      non_formatted_user.save
      expect(non_formatted_user.name).to eq ("Mike Greenlee")
    end

    it "should format already-formatted name to be the same" do
      already_formatted_user.save
      expect(already_formatted_user.name).to eq ("Mark Greentree")
    end
  end
end
