# frozen_string_literal: true

class String # rubocop:disable Style/Documentation
  def to_bool
    return true if self == true || self =~ (/(true|t|yes|y|1)$/i)
    return false if self == false || blank? || self =~ (/(false|f|no|n|0)$/i)

    raise ArgumentError, "invalid value for Boolean: \"#{self}\""
  end

  def to_bool!
    replace(to_bool)
  end

  # Monkey patch Rails `.underscore` method with functionality
  # converts space to underscore.
  def underscore
    gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .gsub(/\s+/, '_')
      .tr('-', '_')
      .downcase
  end

  def underscore!
    replace(underscore)
  end
end

class Integer # rubocop:disable Style/Documentation
  def to_bool
    !zero?
  end

  def to_bool!
    replace(to_bool)
  end
end

class Hash # rubocop:disable Style/Documentation
  # Transform all hash keys to snake case.
  def to_snake_keys
    deep_transform_keys { |key| key.to_s.underscore.to_sym }
    self
  end

  def to_snake_keys!
    deep_transform_keys! { |key| key.to_s.underscore.to_sym }
    self
  end

  # Transform all hash keys to camel case.
  def to_camel_keys
    deep_transform_keys { |key| key.to_s.camelize(:lower).to_sym }
    self
  end

  def to_camel_keys!
    deep_transform_keys! { |key| key.to_s.camelize(:lower).to_sym }
    self
  end
end
