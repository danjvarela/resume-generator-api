class School < ApplicationRecord
  before_save :capitalize_name

  has_many :educations, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: false, scope: :location}

  def self.ransackable_attributes(auth_object = nil)
    ["name", "location"]
  end

  private

  def capitalize_name
    name.capitalize!
  end
end
