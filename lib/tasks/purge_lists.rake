require 'mailchimp'
require 'list_util'

desc "Purge Mailchimp List: EN Order Shipped List"
task :purge_lists => :environment do
  include ListUtil

  list_id = 'c5eb84aba0'
  list_name = 'EN Order Shipped List'
  user_id = 100
  days_old_threshold = BlocMail::Application::DAYS_OLD_THRESHOLD

  @mc = Mailchimp::API.new(ENV['MAILCHIMP_API_KEY'])
  @gibbon_export = Gibbon::Export.new(ENV['MAILCHIMP_API_KEY'])
  members = @gibbon_export.list({:id => list_id})
  members.shift
  unsubscribe_result = cleanup_segment(members, @mc, list_name, list_id, user_id, days_old_threshold)

  puts "number unsubscribed: #{unsubscribe_result["success_count"]}"
  puts "number errors: #{unsubscribe_result["error_count"]}"
end
