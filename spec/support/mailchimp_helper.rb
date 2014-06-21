require 'mailchimp'
require 'faker'

def setup_mc_mocks(list_name, list_id = '123', email = 'admin@example.com')
  mock_mc(list_name, list_id, email)
  mock_gibbon_list(1, email)
end

def mock_mc(list_name, list_id, email = 'admin@example.com')

  list_data = [{'id'=>list_id, 'name'=>list_name, 'stats'=> {'member_count' => 1},
          'date_created'=>'06/14/2014', 'list_rating'=>5}]
  list = {'data' => list_data}

  unsubscribe_result = {'complete'=> true}

  lists_double = double('lists', list: list, unsubscribe: unsubscribe_result)
  mc_double = double('MailChimp', lists: lists_double)
  Mailchimp::API.stub(:new) { mc_double }

  return mc_double
end

def mock_gibbon_list(num_members, email = 'admin@example.com')

  list_data = ["[\"Email Address\",\"First Name\",\"Last Name\",\"MEMBER_RATING\",\"OPTIN_TIME\","+
               "\"OPTIN_IP\",\"CONFIRM_TIME\",\"CONFIRM_IP\",\"LATITUDE\",\"LONGITUDE\",\"GMTOFF\","+
               "\"DSTOFF\",\"TIMEZONE\",\"CC\",\"REGION\",\"LAST_CHANGED\",\"LEID\",\"EUID\"]\n"]

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

