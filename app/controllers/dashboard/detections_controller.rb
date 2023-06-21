# frozen_string_literal: true

module Dashboard
  class DetectionsController < DashboardController
    before_action :authorize_doctor!

    def index; end

    def create
      patient = Patient.new(**patient_params, pathologist: current_user.fullname)
      patient.save!

      respond_turbo_stream notification: { notice: 'Patient created successfully' } do
        turbo_stream.update(
          'detection-result', partial: 'dashboard/partials/detection_results/result',
                              locals: { result: patient.detection_record, patient: }
        )
      end
    rescue Error::FundusServer::ConnectionFailed, Error::FundusServer::ImageInvalid => e
      respond_turbo_stream notification: { alert: e.message } do
        turbo_stream.update('detection-result', **detection_result_empty_template)
      end
    rescue Mongoid::Errors::Validations
      respond_turbo_stream notification: { alert: patient.errors.full_messages } do
        turbo_stream.update('detection-result', **detection_result_empty_template)
      end
    end

    private

    def patient_params
      permitted_params.except(:authenticity_token, :commit)
    end

    def permitted_params
      params.require(:patient).permit(
        :patient_record,
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
