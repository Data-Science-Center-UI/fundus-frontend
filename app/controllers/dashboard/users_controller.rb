# frozen_string_literal: true

module Dashboard
  class UsersController < DashboardController
    before_action :authorize_admin!

    def index
      @users = User.all
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      user = User.new(**user_params)
      user.save!

      # Add User form encapsulated with Turbo Frame
      # So, we need to use Turbo Stream to update the form,
      # and handle Flash Message.
      #
      # Behavior of Turbo Frame is not redirect to new page,
      # instead, it will update the content of the frame.
      respond_to do |format|
        format.turbo_stream do
          flash.now[:notice] = 'User created successfully'

          render turbo_stream: [
            turbo_stream.append('notification', partial: 'dashboard/components/notification'),
            turbo_stream.replace('user-action', partial: 'dashboard/partials/add_user_form')
          ]
        end
      end
    rescue Mongoid::Errors::Validations
      respond_to do |format|
        format.turbo_stream do
          flash.now[:alert] = user.errors.full_messages

          render turbo_stream: [
            turbo_stream.append('notification', partial: 'dashboard/components/notification')
          ]
        end
      end
    end

    def edit; end

    def update; end

    def destroy; end

    private

    def user_params
      permitted_params.except(:authenticity_token, :commit)
    end

    def permitted_params
      params.permit(
        :fullname,
        :username,
        :email,
        :role,
        :password,
        :password_confirmation,
        :authenticity_token,
        :commit
      )
    end
  end
end
