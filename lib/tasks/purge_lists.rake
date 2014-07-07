require 'mailchimp'
require 'list_util'

desc "Purge Mailchimp List: EN Order Shipped List"
task :purge_lists => :environment do
  include ListUtil

  user_id = 100
  days_old_threshold = BlocMail::Application::DAYS_OLD_THRESHOLD

  @mc = Mailchimp::API.new(ENV['MAILCHIMP_API_KEY'])
  @gibbon_export = Gibbon::Export.new(ENV['MAILCHIMP_API_KEY'])

  # clean-up Order Shipped List
  list_id = 'c5eb84aba0'
  list_name = 'EN Order Shipped List'
  members = @gibbon_export.list({:id => list_id})
  members.shift
  unsubscribe_result = cleanup_segment(members, @mc, list_name, list_id, user_id, days_old_threshold)
  puts list_name + " results: "
  puts "  number unsubscribed: #{unsubscribe_result["success_count"]}"
  puts "  number errors: #{unsubscribe_result["error_count"]}"

  # clean-up Order Status List
  list_id = '54bcd36050'
  list_name = 'EN Order Status List'
  members = @gibbon_export.list({:id => list_id})
  members.shift
  unsubscribe_result = cleanup_segment(members, @mc, list_name, list_id, user_id, days_old_threshold)
  puts list_name + " results: "
  puts "  number unsubscribed: #{unsubscribe_result["success_count"]}"
  puts "  number errors: #{unsubscribe_result["error_count"]}"

end
