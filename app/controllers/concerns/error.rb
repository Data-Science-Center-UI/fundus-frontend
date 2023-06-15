# frozen_string_literal: true

# Module Error for Controller
module Error
  class DataNotFound < Lontara::BaseError # rubocop:disable Style/Documentation
    def initialize = super 'Data not found.'
  end

  class UserNotFound < Lontara::BaseError # rubocop:disable Style/Documentation
    def initialize = super 'User not found. Please re-login.'
  end

  class UserNotAuthorized < Lontara::BaseError # rubocop:disable Style/Documentation
    def initialize = super 'User not authorized.'
  end

  ActionDispatch::ExceptionWrapper.rescue_responses.merge!(
    'Error::DataNotFound' => :not_found,
    'Error::UserNotFound' => :unauthorized,
    'Error::UserNotAuthorized' => :forbidden
  )
end
