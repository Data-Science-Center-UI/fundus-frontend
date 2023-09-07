# frozen_string_literal: true

module Callable
  module Patient
    extend ActiveSupport::Concern

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
        detection = ImageDetection.new(fundus_image.path).start

        create_detection_record(detection:, pathologist:, patient_record:, patient_name: fullname) and reload
      end
    end
  end
end
