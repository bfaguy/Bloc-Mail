module ListUtil

  def cleanup_segment(members, mc, list_id, user_id, days_old_threshold)

    email_batch = []

    begin
      members.each do |member_json|
        member = JSON.parse(member_json)
        member_date = Date.parse(member[6])
        days_old = (Date.today) - member_date
        if days_old >= days_old_threshold 
          email_batch << {email: member[0]}
          Rails.logger.info "unsubscribed member: #{member[0]}"
        end
      end
    end

    unsubscribe_result = mc.lists.batch_unsubscribe(list_id, email_batch, false, false, false)

    number_unsubscribed = unsubscribe_result["success_count"]
    unless (number_unsubscribed == 0)
      purge_log = Purge.new()
      purge_log.list_id = list_id 
      purge_log.user_id = user_id
      purge_log.unsubscribed_count = number_unsubscribed

      unless purge_log.save
        # error_message = "Purge could not be saved"
      end
    end

    unsubscribe_result
  end

end
