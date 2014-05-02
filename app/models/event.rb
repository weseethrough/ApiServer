class Event < ActiveRecord::Base
  belongs_to :user

  def merge
    self.save!
    self
  end

  after_commit :send_analytics, :on => :create

  def send_analytics
    logger.info("Event.send_analytics called")
    details = JSON.parse(self.data)

    Analytics.track(
      user_id: self.user_id,
      event: if details.key?(event_type) details.event_type else "unknown event"
      properties: {
        version: self.version,
        device_id: self.device_id,
        session_id: self.session_id
      }.merge(details),
      timestamp: self.created_at
    )

  end

end
