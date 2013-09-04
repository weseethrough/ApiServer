module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def facebook
      standard_provider
    end

    def linkedin
      standard_provider
    end


    protected

      def standard_provider
        @user = User.find_for_provider_oauth(request.env["omniauth.auth"], current_user)

        if @user.persisted?
          sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
          set_flash_message(:notice, :success, :kind => request.env["omniauth.auth"]["provider"].humanize) if is_navigational_format?
        else
          session["devise.provider_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end #standard_provider

  end #OmniauthCallbacksController
end #Users