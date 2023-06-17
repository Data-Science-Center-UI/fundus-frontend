# frozen_string_literal: true

# Patient Model Class
class Patient
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Error::FundusServer

  field :fullname, type: String
  field :birth_day, type: Integer
  field :birth_month, type: Integer
  field :birth_year, type: Integer
  field :age, type: Integer
  field :gender, type: String

  # Add Pathologist by Current User of Doctor Role
  # being recorded as the pathologist who diagnosed the patient
  # in the detection record.
  attr_accessor :pathologist

  # Relations
  has_one :detection_record, dependent: :destroy
  has_mongoid_attached_file :fundus_image

  validates_presence_of :fullname, :age, :fundus_image
  validates_attachment_content_type :fundus_image, content_type: ['image/jpg', 'image/jpeg', 'image/png']
  validates :gender, inclusion: { in: %w[Male Female], message: '%<value>s is not a valid gender' }

  after_save :create_record

  private

  def create_record
    request = LontaraUtilities::HTTPClient.post(
      url: 'http://localhost:5000/detection',
      body: { path: fundus_image.path },
      headers: { content_type: 'application/json' }
    )

    delete and raise ImageInvalid if request.status != 200

    create_detection_record(**JSON.parse(request.body).to_snake_keys!, pathologist:) && reload
  rescue Faraday::ConnectionFailed, Faraday::TimeoutError
    delete and raise ConnectionFailed
  end
end
