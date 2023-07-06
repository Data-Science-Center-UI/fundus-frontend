# frozen_string_literal: true

module Validations
  # Patient Validations
  module Patient
    extend ActiveSupport::Concern
    include Mongoid::Paperclip

    included do
      has_mongoid_attached_file :fundus_image, path: "#{Dir.home}/images/#{SecureRandom.hex}.:extension"

      validates :gender, inclusion: { in: %w[Male Female], message: '%<value>s is not a valid gender' }
      validates_presence_of :fullname, :age, :fundus_image
      validates_attachment_content_type :fundus_image, content_type: ['image/jpg', 'image/jpeg', 'image/png']
    end
  end
end
