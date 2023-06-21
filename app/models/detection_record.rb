# frozen_string_literal: true

# Detection Record Model Class for Patient
class DetectionRecord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :patient_record, type: String
  field :patient_name, type: String
  field :pathologist, type: String
  field :diabethic_retinopathy, type: Array
  field :laser_scars, type: Array
  field :media_haze, type: Array
  field :brvo, type: Array
  field :crvo, type: Array

  # Relations
  belongs_to :patient

  index({ patient_record: 'text', patient_name: 'text' })
end
