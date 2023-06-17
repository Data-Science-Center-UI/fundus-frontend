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

  module FundusServer
    class ConnectionFailed < Lontara::BaseError # :nodoc:
      def initialize = super 'Detection cannot be processed. Connection to Fundus Processing Server failed.'
    end

    class ImageInvalid < Lontara::BaseError # :nodoc:
      def initialize = super 'Detection cannot be processed. Image is invalid. Please check your image and try again.'
    end
  end

  ActionDispatch::ExceptionWrapper.rescue_responses.merge!(
    'Error::DataNotFound' => :not_found,
    'Error::UserNotFound' => :unauthorized,
    'Error::UserNotAuthorized' => :forbidden,
    'Error::FundusServer::ConnectionFailed' => :internal_server_error,
    'Error::FundusServer::ImageInvalid' => :unprocessable_entity
  )
end
