class Company < ApplicationRecord
  has_many :jobs
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  scope :filter_by_name, ->(str) { where("name ~* ?", str) }
end
