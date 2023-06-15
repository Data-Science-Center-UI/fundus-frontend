# frozen_string_literal: true

module Dashboard
  class DetectionsController < DashboardController
    before_action :authorize_doctor!

    def index; end

    def create
      patient = Patient.new(**create_params, pathologist: current_user.fullname)

      redirect_to dashboard_detections_path, alert: patient.errors.full_messages and return unless patient.save!
      redirect_to dashboard_detections_path, alert: patient.errors.full_messages and return if patient.errors.any?

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            'detection-result', partial: 'dashboard/partials/detection_result',
                                locals: { patient: }
          )
        end

        format.html { redirect_to dashboard_detections_path }
      end
    end

    private

    def create_params
      permitted_params.except(:authenticity_token, :commit)
    end

    def permitted_params
      params.permit(
        :fullname,
        :birth_day,
        :birth_month,
        :birth_year,
        :age,
        :gender,
        :fundus_image,
        :authenticity_token,
        :commit
      )
    end
  end
end
