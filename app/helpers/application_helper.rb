# frozen_string_literal: true

module ApplicationHelper
  GENDER = [%w[Male Male], %w[Female Female]].freeze
  MONTHNAMES = Date::MONTHNAMES.compact.map.with_index { |month, index| [month, index + 1] }
  PATIENT_DATA = %i[fullname birthdate age gender].freeze
  DIAGNOSIS = %i[media_haze laser_scars diabethic_retinopathy brvo crvo].freeze
  ROLE = %i[Admin Doctor].freeze

  # Create Birthdate from Day Month Year
  # to Month Day, Year
  def birthdate(day, month, year)
    "#{Date::MONTHNAMES[month]} #{day}, #{year}"
  end

  def detection_result_empty_template
    { partial: 'dashboard/components/result_empty',
      locals: { title: 'Nothing happens here',
                description: 'Upload Fundus Image and Submit to get Detection Result.',
                lottie_url: 'https://assets4.lottiefiles.com/packages/lf20_iikbn1ww.json' } }
  end
end
