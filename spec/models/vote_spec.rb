require 'rails_helper'
include RandomData

RSpec.describe Vote, type: :model do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:my_vote) { create(:vote, post: post, user: user) }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_inclusion_of(:value).in_array([-1,1]) }

  describe "update_post callback" do
    it "triggers update_post on save" do
      expect(my_vote).to receive(:update_post).at_least(:once)
      my_vote.save!
    end

    it "#update_post should call update_rank on save" do
      expect(post).to receive(:update_rank).at_least(:once)
      my_vote.save!
    end
  end
end
