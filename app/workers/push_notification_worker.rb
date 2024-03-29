require 'gcm'
require 'apns'

class PushNotificationWorker
  include Sidekiq::Worker
    
  # NOTE: data is serialized+deserialized as JSON so symbols are converted to strings
  def perform(user_id, data)
    # Android devices
    reg_ids = Device.where(user_id: user_id).where.not(:push_id => [nil, ""]).where.not(:manufacturer => 'Apple').flat_map {|d| d.push_id}
    unless reg_ids.empty?
      options = {data: data}
      gcm = GCM.new(CONFIG[:google][:api_key])
      response = gcm.send_notification(reg_ids.uniq, options)
      logger.info response
    end
    # iOS devices
    reg_ids = Device.where(user_id: user_id).where.not(:push_id => [nil, ""]).where(:manufacturer => 'Apple').flat_map {|d| d.push_id}
    unless reg_ids.empty?
      APNS.host = CONFIG[:apple][:apns_host]
      APNS.pem = CONFIG[:apple][:apns_pem]
      unread = Notification.where(user_id: user_id).where(:read => false).count
      reg_ids.uniq.each do |device_token| 
        APNS.send_notification(device_token, :alert => data['title'], :badge => unread, :sound => 'default', :content_available => 1)
        logger.info "Apple push notification sent to " + device_token
      end
      logger.info APNS.feedback
    end
  end
    
end
