require 'spec_helper'

describe ListsController do 

  let(:user) { create(:user) }
  let(:member_email) {'guy@bloc.com'}
  let(:list_id) { '123' }

  before(:each) do
    sign_in user
  end

  describe "#purge" do
    it "removes any old emails address from the list succesfully" do
      double_mc = setup_mc_list("new list", list_id, member_email)
      setup_gibbon_list(member_email, 3)

      # expect_any_instance_of(Mailchimp::Lists).to receive(:unsubscribe).once
      expect(double_mc.lists).to receive(:unsubscribe).once
      post :purge, :id => list_id
    end
  end

end
