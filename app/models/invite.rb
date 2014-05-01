class Invite < ActiveRecord::Base
  belongs_to :user # may be null
  belongs_to :identity # may be null (code FFA)
  
  def expired?
    return expires_at != nil && Time.now > expires_at
  end

  def used?
    return used_at != nil
  end

  def self.generate_for(user)
    max_invites = 3 # TODO: Fetch value by user || group || global

    while user.invites < max_invites
      loop do
        user = User.find(user.id) # Refresh user
        break if user.invites >= max_invites
        random_token = SecureRandom.urlsafe_base64(nil, false)
        begin
          # Create invite
          invite = Invite.create!(code: random_token, user_id: user.id)
          # Verify count
          User.increment_counter(:invites, user.id) # Atomic increment
          user = User.find(user.id)
          if user.invites > max_invites # Race condition
            User.decrement_count(:invited, user.id)
            invite.destroy!
            # Retry while loop
            user = User.find(user.id)
            break
          end
        rescue ActiveRecord::RecordNotUnique
          # Continue loop
          # TODO: Remove/overwrite expired and used (after a safety period)
        end
      end
    end

    Invite.where(user_id: user.id).where('expires_at IS NULL or expires_at < ?', Time.now)
  end

end
