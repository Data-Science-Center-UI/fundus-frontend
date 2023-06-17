# frozen_string_literal: true

# Class Errors Controller
class ErrorsController < ApplicationController
  layout 'error'

  def show
    exception = request.env['action_dispatch.exception']
    status_code = exception.try(:status_code) ||
                  ActionDispatch::ExceptionWrapper.new(request.env, exception).status_code

    @error_detail = HashToStruct.struct supported_error_codes(status_code)

    render 'errors/show', status: status_code
  end
end
