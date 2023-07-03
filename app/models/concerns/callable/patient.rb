# frozen_string_literal: true

module Callable
  module Patient
    extend ActiveSupport::Concern
    include Error::FundusServer

    included do
      before_save :set_patient_record, if: -> { patient_record.blank? }
      before_save :set_birthdate

      after_save :create_record

      private

      def set_patient_record
        self.patient_record = "#{fullname.split.last}-#{id.to_s.last(5)}".upcase
      end

      def set_birthdate
        self.birthdate = Date.new(birth_year.to_i, birth_month.to_i, birth_day.to_i)
      end

      def create_record
        fundus_host = Rails.application.credentials.dscui.fundus

        request = LontaraUtilities::HTTPClient.post(
          url: Rails.env.production? ? fundus_host.prod : fundus_host.dev,
          body: { path: fundus_image.path },
          headers: { content_type: 'application/json' }
        )

        delete and raise ImageInvalid if request.status != 200

        result = JSON.parse(request.body).to_snake_keys!
        create_detection_record(**result, pathologist:, patient_record:, patient_name: fullname) && reload
      rescue Faraday::ConnectionFailed, Faraday::TimeoutError
        delete and raise ConnectionFailed
      end
    end
  end
end
