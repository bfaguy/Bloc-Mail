require 'spec_helper'

describe ListsController do 

  let(:list_name) {'new list'}
  let(:list_id) {'123'}
  let(:member_email) {'guy@bloc.com'}

  describe "#purge" do

    it "removes any old emails address from the list succesfully" do
      setup_mc(list_name, list_id, member_email)
      expect{ post :purge }.to change{ List.count }.by 1
      # expect(response.body).to include "List was not created"
      # expect(assigns(:list).errors.messages.to_s).to include "List name already exists"
    end
  end

end
