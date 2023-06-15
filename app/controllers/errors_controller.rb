# frozen_string_literal: true

# Class Errors Controller
class ErrorsController < ApplicationController
  def show
    @exception = request.env['action_dispatch.exception']
    @status_code = @exception.try(:status_code) ||
                   ActionDispatch::ExceptionWrapper.new(request.env, @exception).status_code

    render view_for_code(@status_code), status: @status_code
  end

  private

  def view_for_code(code)
    supported_error_codes(code)
  end

  def supported_error_codes(code, fallback = '500')
    { 401 => '401', 403 => '403', 404 => '404', 500 => '500' }.fetch(code, fallback)
  end
end
