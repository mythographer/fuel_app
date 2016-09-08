class VinValidator < ActiveModel::EachValidator
  VALID_VIN_REGEX = /\A([A-HJ-NPR-Z0-9]){3}([A-Z0-9]{6})([A-Z0-9]){8}\z/
  VIN_SIZE = 17
  def validate_each(record, attribute, value)
    unless value =~ VALID_VIN_REGEX
      record.errors[attribute] << (options[:message] || "wrong VIN")
    end
    unless value.present? and value.size == VIN_SIZE
      record.errors[attribute] << (options[:message] || "is the wrong length (should be #{VIN_SIZE} characters)")
    end
  end
end
