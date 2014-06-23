require 'spec_helper'

describe ListsController do 

  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  describe "POST #purge" do
    it "removes any old emails address from the list succesfully" do
      list_id = '123'
      double_mc = mock_mc("new list", list_id)
      mock_gibbon_list(3)

      expect(double_mc.lists).to receive(:batch_unsubscribe).once
      expect(Rails.logger).to receive(:info).exactly(1).times
      post :purge, :id => list_id
    end

    it "logs the purges in database" do
      list_id = '123'
      mock_mc("new list", list_id)
      mock_gibbon_list(3)

      expect{ 
        post :purge, :id => list_id
      }.to change(Purge,:count).by(1) 
    end

  end

end
