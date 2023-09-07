# frozen_string_literal: true

class ImageDetection
  def initialize(path)
    @path = path
  end

  attr_reader :path

  def start
    fundus_host = Rails.application.credentials.dscui.fundus

    request = LontaraUtilities::HTTPClient.post(
      url: Rails.env.production? ? fundus_host.prod : fundus_host.dev,
      body: { path: },
      headers: { content_type: 'application/json' }
    )

    raise Error::FundusServer::ImageInvalid if request.status != 200

    JSON.parse(request.body).to_snake_keys!
  rescue Faraday::ConnectionFailed, Faraday::TimeoutError
    raise Error::FundusServer::ConnectionFailed
  end
end
