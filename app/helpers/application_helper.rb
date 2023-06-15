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
end
