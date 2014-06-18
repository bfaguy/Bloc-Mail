module ListUtil

  def cleanup_segment(members, mc)
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
    
    # purge_log = Purge.new(params)
    # purge_log.save

    number_unsubscribed
  end

end
