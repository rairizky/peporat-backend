class ApplicationController < ActionController::API

    def encode_token(payload)
        JWT.encode(payload, 's3cr3t')
    end

    def auth_header
        # Authorization: ....
        request.headers['Authorization']
    end

    def decode_token
        if auth_header
            token = auth_header.split(' ')[1]
            # Bearer xxx
            begin
                JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')                
            rescue JWT::DecodeError
                nil
            end
        end
    end

    # all author
    def logged_in_user
        if decode_token
            user_id = decode_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def logged_in?
        !!logged_in_user
    end

    def authorized
        render json: { message: 'You are not authorized!' }, status: :unauthorized unless logged_in?
    end

    # admin
    def logged_in_user_admin
        if decode_token
            user_id = decode_token[0]['user_id']
            @user = User.where(id: user_id).where(role: 'admin').first
        end
    end

    def logged_in_admin?
        !!logged_in_user_admin
    end

    def authorized_admin
        render json: { message: 'You are not authorized!' }, status: :unauthorized unless logged_in_admin?
    end

    # petugas
    def logged_in_user_petugas
        if decode_token
            user_id = decode_token[0]['user_id']
            @user = User.where(id: user_id).where(role: 'petugas').first
        end
    end

    def logged_in_petugas?
        !!logged_in_user_petugas
    end

    def authorized_petugas
        render json: { message: 'You are not authorized!' }, status: :unauthorized unless logged_in_petugas?
    end

    # user
    def logged_in_user_user
        if decode_token
            user_id = decode_token[0]['user_id']
            @user = User.where(id: user_id).where(role: 'user').first
        end
    end

    def logged_in_user?
        !!logged_in_user_user
    end

    def authorized_user
        render json: { message: 'You are not authorized!' }, status: :unauthorized unless logged_in_user?
    end
end
