# frozen_string_literal: true

module Dashboard
  # Base Controller for Dashboard
  class DashboardController < ApplicationController
    layout 'dashboard'

    def index
      redirect_to dashboard_detections_path if current_user.doctor?
      redirect_to dashboard_users_path if current_user.admin?
    end

    private

    def authorize_doctor!
      raise Error::UserNotAuthorized unless current_user.doctor?
    end

    def authorize_admin!
      raise Error::UserNotAuthorized unless current_user.admin?
    end
  end
end
