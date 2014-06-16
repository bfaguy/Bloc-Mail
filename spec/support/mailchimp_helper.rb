require 'mailchimp'

def setup_mc(id, name, email = 'admin@example.com')

  list_data = []
  list = {'id'=>id, 'name'=>name, 'stats'=> {'member_count' => 1},
          'date_created'=>'06/14/2014', 'list_rating'=>5}
  list_data << list
  list = {'data' => list_data}

  members_data = []
  member = {'email' => email, 'timestamp'=>'01/01/2001'}
  members_data << member
  members = {'data' => members_data}

  Mailchimp::Lists.stub(:unsubscribe) do |arg1, arg2, arg3|

  end

  Mailchimp::Lists.stub(:new) { mock('lists', list: list, members: members) }
  lists = Mailchimp::Lists.new
  Mailchimp::API.stub(:new) { mock('MailChimp', lists: lists)}
end
