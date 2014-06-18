require 'mailchimp'

def setup_mc_to_test_pagination(email, list_id)
  gibbon = Gibbon::Export.new(ENV['MAILCHIMP_API_KEY'])
  original = gibbon.list({:id => list_id})
  header = original.shift
  original.unshift("[\"#{email}\",\"Joshua\",\"Tree\",2,\"\",null,\"2014-06-17 00:19:17\","+
                   "\"70.165.46.157\",null,null,null,null,null,null,null,\"2014-06-17 00:19:17\","+
                   "\"348602965\",\"625d4b0e09\"]\n")
  original.unshift(header)
  Gibbon::Export.stub(:new) { double("list", list: original) }
end

def setup_mc(name, id = '123', email = 'admin@example.com')
  setup_mc_list id, name, email
  setup_mc_list_members id
end

def setup_mc_list_members(list_id)
  # member_data = {..}
  # Mailchimp::Lists.stub(:members) { member_data }
end

def setup_mc_list(id, name, email)
  list_data = []
  list = {'id'=>id, 'name'=>name, 'stats'=> {'member_count' => 1},
          'date_created'=>'06/14/2014', 'list_rating'=>5}
  list_data << list
  list = {'data' => list_data}

  members_data = []
  member = {'email' => email, 'timestamp'=>'01/01/2001'}
  members_data << member
  members = {'data' => members_data}

  # Mailchimp::Lists.stub(:unsubscribe) do |arg1, arg2, arg3|
  # end

  Mailchimp::Lists.stub(:new) { double('lists', list: list, members: members) }
  lists = Mailchimp::Lists.new
  Mailchimp::API.stub(:new) { double('MailChimp', lists: lists)}
end
