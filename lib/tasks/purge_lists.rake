require 'mailchimp'
require 'list_util'

desc "Purge Mailchimp Lists"
task :purge_lists => :environment do
  include ListUtil

  user_id = 100 # Heroku Scheduler (user)
  @mc = Mailchimp::API.new(ENV['MAILCHIMP_API_KEY'])
  @gibbon_export = Gibbon::Export.new(ENV['MAILCHIMP_API_KEY'])

  cleanup_list('c5eb84aba0', 'EN Order Shipped List', user_id)

  cleanup_list('54bcd36050', 'EN Order Status List', user_id)

end


def cleanup_list(list_id, list_name, user_id)

  members = @gibbon_export.list({:id => list_id})
  headers = JSON.parse(members.shift)

  for i in 0.. headers.length
    if headers[i] == "Email Address"
      email_index = i
    elsif headers[i] == "CONFIRM_TIME"
      confirmtime_index = i
    end
  end

  unsubscribe_result = cleanup_segment(members, @mc, list_name, list_id, user_id, email_index, confirmtime_index)

  puts list_name + " results: "
  puts "  number unsubscribed: #{unsubscribe_result["success_count"]}"
  puts "  number errors: #{unsubscribe_result["error_count"]}"
end
