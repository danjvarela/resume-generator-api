class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name"]
  end
end
