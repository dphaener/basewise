module Transactable
  extend ActiveSupport::Concern

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def catch_errors(&block)
    ActiveRecord::Base.transaction { yield }
    true
  rescue ActiveRecord::ActiveRecordError => ex
    errors.add(:base, "An unexpected error occurred")
    false
  end

  def value_to_boolean(value)
    return if value.is_a?(String) && value.blank?
    ["1", "t", "true", true].include?(value)
  end

  def persisted?
    false
  end
end