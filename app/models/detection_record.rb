# frozen_string_literal: true

# Detection Record Model Class for Patient
class DetectionRecord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :patient_record, type: String
  field :patient_name, type: String
  field :pathologist, type: String
  field :detection, type: Hash

  # Relations
  belongs_to :patient

  index({ patient_record: 'text', patient_name: 'text' })
end
