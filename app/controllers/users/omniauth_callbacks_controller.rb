# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    Devise.omniauth_configs.each_key do |provider|
      define_method provider do
        data = request.env["omniauth.auth"]["info"]
        @user = User.find_by(email: data["email"])
        @user ||= User.create(
          full_name: data["name"],
          email: data["email"],
          password: Devise.friendly_token[0, 20],
          uid: request.env["omniauth.auth"]["uid"],
          provider: request.env["omniauth.auth"]["provider"]
        )
        check_user
      end
    end

    def check_user
      if @user.persisted?
        flash[:notice] = "success"
        sign_in_and_redirect @user, event: :authentication
      else
        flash[:notice] = "failure"
        redirect_to new_user_registration_url
      end
    end
  end
end
