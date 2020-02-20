class Rate < ActiveRecord::Base
  belongs_to :masseur_detail
  delegate :masseur, to: :masseur_detail, allow_nil: true
  
  # All rates (incall, outcall, other) always need a masseur (detail) type.
  validates :masseur_detail,
            :rate_type,
            presence: true

  # Incall and outcall rates need a rate and time
  validates :rate, :time,
            presence: true,
            if: "rate_type != RATE_OTHER"

  # "Other Services" rates need a description
  validates :description,
            presence: true,
            if: "rate_type == RATE_OTHER"
end
