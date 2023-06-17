# frozen_string_literal: true

module Dashboard
  class DetectionResultsController < DashboardController
    before_action :authorize_doctor!

    def index
      @detection_reports = DetectionRecord.all
    end
  end
end
