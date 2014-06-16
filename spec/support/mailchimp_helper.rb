require 'mailchimp'

def setup_mc(name)

   @data = []
   list = {'id'=>'1234', 'name'=>name, 'stats'=> {'member_count' => 0},
    'date_created'=>'06/14/2014', 'list_rating'=>5}
   @data << list

   list = {'data' => @data}
   Mailchimp::Lists.stub(:new) { mock('lists', list: list) }
   lists = Mailchimp::Lists.new
   Mailchimp::API.stub(:new) { mock('MailChimp', lists: lists)}
end
