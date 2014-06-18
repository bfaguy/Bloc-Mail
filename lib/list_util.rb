module ListUtil

  def cleanup_segment(members, mc, list_id, user_id)
    number_unsubscribed = 0
    begin
      members.each do |member_json|
        member = JSON.parse(member_json)
        member_date = Date.parse(member[6])
        days_old = (Date.today) - member_date
        if days_old > BlocMail::Application::DAYS_OLD_THRESHOLD
          return_value = mc.lists.unsubscribe(params[:id], 
                                               {'email' => member[0]}, :delete_member => false,
                                               :send_goodbye => false, 
                                               :send_notify => false)
          if (return_value['complete'])
            number_unsubscribed += 1
            Rails.logger.info "just cleaned up semgnet"
          end
        end
      end
    end

    purge_log = Purge.new()
    purge_log.list_id = list_id 
    purge_log.user_id = user_id
    purge_log.unsubscribed_count = number_unsubscribed

    unless purge_log.save
      error_message = "Purge could not be saved"
    end

    {number_unsubscribed: number_unsubscribed, error_message: error_message}
  end

end
