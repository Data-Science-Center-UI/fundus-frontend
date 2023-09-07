# frozen_string_literal: true

module ApplicationHelper
  # Patient Attributes
  GENDER = [%w[Male Male], %w[Female Female]].freeze
  MONTHNAMES = Date::MONTHNAMES.compact.map.with_index { |month, index| [month, index + 1] }
  PATIENT_ATTRIBUTES = %i[patient_record fullname birthdate age gender].freeze

  # User Attributes
  USER_ATTRIBUTES = %i[fullname username email role status].freeze
  USER_STATUS = { true => 'Active', false => 'Inactive' }.freeze
  ROLE = %i[Admin Doctor].freeze

  # Formated date as Month Day, Year
  def formated_date(day, month, year)
    "#{Date::MONTHNAMES[month]} #{day}, #{year}"
  end

  def detection_result_empty_template
    { partial: 'dashboard/components/result_empty',
      locals: { title: 'Nothing happens here',
                description: 'Upload Fundus Image and Submit to get Detection Result.',
                lottie_url: ActionController::Base.helpers.asset_path('new-sin-movs') } }
  end

  def show_result_empty_template
    { partial: 'dashboard/components/result_empty',
      locals: { title: 'Nothing happens here',
                description: 'Show detection result by click each data from list.',
                lottie_url: ActionController::Base.helpers.asset_path('man-with-task-list') } }
  end

  def load_more_template(src)
    { partial: 'dashboard/components/load_more', locals: { src: } }
  end

  def supported_error_codes(code, fallback = 500)
    {
      401 => {
        code: '401',
        status: 'Unauthorized',
        message: 'You are not authorized to access this page. Please Login.'
      },
      403 => {
        code: '403',
        status: 'Forbidden',
        message: 'Your role is not authorized to access this page. Please contact your administrator.'
      },
      404 => {
        code: '404',
        status: 'Not Found',
        message: 'The page you are looking for does not exist. Either link is missing, or the page has been removed.'
      },
      500 => {
        code: '500',
        status: 'Internal Server Error',
        message: 'Something went wrong. Please try again later.'
      }
    }.fetch(code, fallback)
  end
end
