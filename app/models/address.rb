class Address < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates :line1, :zip, presence: true
  validates :zip, numericality: { only_integer: true }, length: { maximum: 6 }
  validates :country, presence: true
  validates :state, inclusion: { in: ->(record) { record.states.keys }, allow_blank: true }
  validates :state, presence: { if: ->(record) { record.states.present? } }
  validates :city, inclusion: { in: ->(record) { record.cities }, allow_blank: true }
  validates :city, presence: { if: ->(record) { record.cities.present? } }

  def to_s
    [country_label, city, line1, line2, state, zip].select(&:present?).join(', ')
  end

  def countries
    CS.countries.with_indifferent_access
  end

  def states
    CS.states(country).with_indifferent_access
  end

  def cities
    CS.cities(state, country) || []
  end

  def country_label
    countries[country]
  end

  # def state_label
  #   states[state]
  # end
end
