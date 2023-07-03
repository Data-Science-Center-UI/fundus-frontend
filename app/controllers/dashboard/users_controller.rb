# frozen_string_literal: true

module Dashboard
  class UsersController < DashboardController
    include UserHelper

    before_action :authorize_admin!

    def index; end

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def create
      user = User.new(**user_params)
      user.save!

      respond_turbo_stream notification: { notice: 'User created successfully' } do
        [
          turbo_stream.update(
            'user-action', partial: 'dashboard/partials/users/form',
                           locals: { url: dashboard_users_path, method: :post }
          ),
          turbo_stream.prepend('user-data', partial: 'dashboard/partials/users/list_data', locals: { user: })
        ]
      end
    rescue Mongoid::Errors::Validations
      respond_turbo_stream notification: { alert: user.errors.full_messages } do
        turbo_stream.append('notification', partial: 'dashboard/components/notification')
      end
    end

    def update
      user = User.find(params[:id])
      user.update!(**user_params.compact_blank) # Allow to update only the fields that are not blank

      respond_turbo_stream notification: { notice: 'User updated successfully' } do
        [
          turbo_stream.update('user-action', **user_action_empty_template),
          turbo_stream.replace(user.id.to_s, partial: 'dashboard/partials/users/list_data', locals: { user: })
        ]
      end
    rescue Mongoid::Errors::Validations
      respond_turbo_stream notification: { alert: user.errors.full_messages } do
        turbo_stream.append('notification', partial: 'dashboard/components/notification')
      end
    end

    def destroy
      user = User.find(params[:id])
      user.discard!

      respond_turbo_stream notification: { notice: 'User deactivation successfully' } do
        [
          turbo_stream.update('user-action', **user_action_empty_template),
          turbo_stream.replace(user.id.to_s, partial: 'dashboard/partials/users/list_data', locals: { user: })
        ]
      end
    end

    def activate
      user = User.find(params[:id])
      user.undiscard!

      respond_turbo_stream notification: { notice: 'User activation successfully' } do
        [
          turbo_stream.update('user-action', **user_action_empty_template),
          turbo_stream.replace(user.id.to_s, partial: 'dashboard/partials/users/list_data', locals: { user: })
        ]
      end
    end

    def lists
      @users = User.order(discarded_at: :asc).paginate(page: params[:page])
      @users = User.text_search(params[:query]) if params[:query]&.present?

      respond_turbo_stream do
        search_list = lambda do
          [
            turbo_stream.update('user-data', **user_list_data_template(@users, collection: true)),
            turbo_stream.remove('load-more')
          ]
        end

        default_list = lambda do
          data = [turbo_stream.append('user-data', **user_list_data_template(@users, collection: true))]

          data << if @users.next_page
                    turbo_stream.replace(
                      'load-more', **load_more_template(
                        dashboard_users_lists_path(page: @users.next_page, query: params[:query], format: :turbo_stream)
                      )
                    )
                  else
                    turbo_stream.remove('load-more')
                  end
        end

        params[:query]&.present? && !params[:query].eql?('') ? search_list.call : default_list.call
      end
    end

    def search
      @users = params[:query].present? ? User.text_search(params[:query]) : user_lists

      render partial: 'dashboard/partials/users/lists', locals: { users: @users }
    end

    private

    def user_params
      permitted_params.except(:authenticity_token, :commit)
    end

    def permitted_params
      params.require(:user).permit(
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
