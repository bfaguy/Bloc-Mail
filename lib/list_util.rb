module ListUtil

  def cleanup_segment(members, mc, list_name, list_id, user_id, days_old_threshold)

    email_batch = []

    members.each do |member_json|
      member = JSON.parse(member_json)
      member_date = Date.parse(member[6])
      days_old = (Date.today) - member_date
      if days_old >= days_old_threshold 
        email_batch << {email: member[0]}
        Rails.logger.info "unsubscribed member: #{member[0]}"
      end
    end

    unsubscribe_result = mc.lists.batch_unsubscribe(list_id, email_batch, false, false, false)

    number_unsubscribed = unsubscribe_result["success_count"]
    unless (number_unsubscribed == 0)
      purge_log = Purge.new()
      purge_log.list_name = list_name
      purge_log.list_id = list_id 
      purge_log.user_id = user_id
      purge_log.unsubscribed_count = number_unsubscribed
      purge_log.errors_count = unsubscribe_result["error_count"]

      unless purge_log.save
        flash[:error] = "Purge could not be saved"
      end
    end

    unsubscribe_result
  end

end
