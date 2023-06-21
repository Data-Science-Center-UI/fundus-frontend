# frozen_string_literal: true

# Patient Model Class
class Patient
  include Mongoid::Document
  include Mongoid::Timestamps
  include Validations::Patient
  include Callable::Patient

  field :patient_record, type: String
  field :fullname, type: String
  field :birthdate, type: Date
  field :age, type: Integer
  field :gender, type: String

  # Add Pathologist by Current User of Doctor Role
  # being recorded as the pathologist who diagnosed the patient
  # in the detection record.
  attr_accessor :birth_day, :birth_month, :birth_year, :pathologist

  # Relations
  has_one :detection_record, dependent: :destroy
end
