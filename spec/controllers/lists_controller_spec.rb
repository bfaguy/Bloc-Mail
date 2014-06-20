require 'spec_helper'

describe ListsController do 

  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  describe "#purge" do
    it "removes any old emails address from the list succesfully" do
      list_id = '123'
      double_mc = mock_mc("new list", list_id)
      mock_gibbon_list(3)

      # expect_any_instance_of(Mailchimp::Lists).to receive(:unsubscribe).once
      expect(double_mc.lists).to receive(:unsubscribe).once
      post :purge, :id => list_id
    end
  end

end
