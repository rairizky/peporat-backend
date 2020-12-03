class ProfileController < ApplicationController

    before_action :authorized
    before_action :check_has_profile, only: [:index, :update]

    def index
        @profile = @user.profile
        render json: {status: true, profile: @profile}, status: :ok
    end

    def create
        get_user = User.find(@user.id)
        if get_user.profile == nil
            @create_profile = get_user.create_profile(profile_params)
            if @create_profile.valid?
                render json: {status: true, message: 'Profile berhasil dibuat!'}, status: :created
            else
                render json: {status: false, error: @create_profile.errors}, status: :unprocessable_entity
            end
        else
            render json: {status: false, message: 'Profile sudah ada!'}, status: :conflict
        end
        
    end

    def update
        @update_profile = Profile.find_by(user_id: @user.id)
        if @update_profile.update(profile_update_params)
            if params[:image].present?
                @update_profile.remove_image!
            end
            @update_profile.save
            render json: {status: true, message: 'Profile berhasil diupdate!'}, status: :ok
        else
            render json: {status: false, error: @update_profile.errors}, status: :unprocessable_entity
        end
    end

    private
    def profile_params
        params.permit(:nik, :image, :nama, :telp)
    end

    def profile_update_params
        params.permit(:image, :nama, :telp)
    end
end
