class ProfileController < ApplicationController

    before_action :authorized

    def index
        @profile = @user.profile
        render json: {status: true, profile: @profile}, status: :ok
    end
end
