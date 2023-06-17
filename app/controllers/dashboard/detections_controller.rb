# frozen_string_literal: true

module Dashboard
  class DetectionsController < DashboardController
    before_action :authorize_doctor!

    def index; end

    def create
      patient = Patient.new(**patient_params, pathologist: current_user.fullname)
      patient.save!

      respond_to do |format|
        format.turbo_stream do
          flash.now[:notice] = 'Patient created successfully'

          render turbo_stream: [
            turbo_stream.prepend('notification', partial: 'dashboard/components/notification'),
            turbo_stream.update(
              'detection-result', partial: 'dashboard/partials/detection_result',
                                  locals: { patient: }
            )
          ]
        end
      end
    rescue Error::FundusServer::ConnectionFailed, Error::FundusServer::ImageInvalid => e
      respond_to_error e.message
    rescue Mongoid::Errors::Validations
      respond_to_error patient.errors.full_messages
    end

    private

    def patient_params
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

    def respond_to_error(message)
      respond_to do |format|
        format.turbo_stream do
          flash.now[:alert] = message

          render turbo_stream: [
            turbo_stream.prepend('notification', partial: 'dashboard/components/notification'),
            turbo_stream.update('detection-result', **detection_result_empty_template)
          ]
        end
      end
    end
  end
end
