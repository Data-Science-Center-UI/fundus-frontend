# frozen_string_literal: true

module Dashboard
  class UsersController < DashboardController
    before_action :authorize_admin!

    def index
      @users = User.all
    end

    def show; end

    def new; end

    def create; end

    def edit; end

    def update; end

    def destroy; end
  end
end
