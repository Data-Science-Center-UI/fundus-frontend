# frozen_string_literal: true

module Validations
  # User Validations
  module User
    extend ActiveSupport::Concern

    included do
      validates :role, inclusion: { in: %w[Admin Doctor], message: '%<value>s is not a valid role' }
      validates_format_of :username, with: /^[a-zA-Z0-9_.]*$/, multiline: true
      validates_presence_of :fullname, :role
      validates_confirmation_of :password, if: -> { password.present? }
      validates_uniqueness_of :username, case_sensitive: false
    end
  end
end
