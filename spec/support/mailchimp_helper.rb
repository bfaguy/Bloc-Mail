require 'mailchimp'
require 'faker'

def setup_mc(list_name, list_id = '123', email = 'admin@example.com')
  setup_mc_list(list_name, list_id, email)
  setup_gibbon_list(email, 1)
end

def setup_mc_list(list_name, list_id, email)

  list_data = []
  list = {'id'=>list_id, 'name'=>list_name, 'stats'=> {'member_count' => 1},
          'date_created'=>'06/14/2014', 'list_rating'=>5}
  list_data << list
  list = {'data' => list_data}

  members_data = []
  member = {'email' => email, 'timestamp'=>'01/01/2001'}
  members_data << member
  members = {'data' => members_data}

  unsubscribe_result = {'complete'=> true}

  lists_double = double('lists', list: list, members: members, unsubscribe: unsubscribe_result)
  mc_double = double('MailChimp', lists: lists_double)
  Mailchimp::API.stub(:new) { mc_double }

  return mc_double
end


def setup_gibbon_list(email, num_members)

  list_data = ["[\"Email Address\",\"First Name\",\"Last Name\",\"MEMBER_RATING\",\"OPTIN_TIME\",\"OPTIN_IP\",\"CONFIRM_TIME\",\"CONFIRM_IP\",\"LATITUDE\",\"LONGITUDE\",\"GMTOFF\",\"DSTOFF\",\"TIMEZONE\",\"CC\",\"REGION\",\"LAST_CHANGED\",\"LEID\",\"EUID\"]\n"]

  member_data = "[\"#{email}\",\"Joshua\",\"Tree\",2,\"\",null,\"2013-06-17 00:19:17\","+
    "\"70.165.46.157\",null,null,null,null,null,null,null,\"2014-06-17 00:19:17\","+
    "\"348602965\",\"625d4b0e09\"]\n"
  list_data << member_data

  num_members.times do
    member_data = "[\"#{Faker::Internet.email}\",\"Joshua\",\"Tree\",2,\"\",null,\"#{Time.now}\","+
      "\"70.165.46.157\",null,null,null,null,null,null,null,\"2014-06-17 00:19:17\","+
      "\"348602965\",\"625d4b0e09\"]\n"
    list_data << member_data
  end

  Gibbon::Export.stub(:new) { double("list", list: list_data) }
end

