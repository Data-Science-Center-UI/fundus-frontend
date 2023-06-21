# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :add_noindex_header, :authenticate_user!

  private

  def respond_turbo_stream(notification: nil)
    respond_to do |format|
      format.turbo_stream do
        flash.now[notification.keys.first] = notification.values.first if notification
        flash_template = turbo_stream.append('notification', partial: 'dashboard/components/notification')

        render turbo_stream: if block_given?
                               yield.is_a?(Array) ? [flash_template].concat(yield) : [flash_template] << yield
                             else
                               flash_template
                             end
      end
    end
  end

  # Add NoIndex header to prevent search engines from indexing the page
  def add_noindex_header
    response.headers['X-Robots-Tag'] = 'noindex'
  end
end
