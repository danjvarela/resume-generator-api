class Resume < ApplicationRecord
  belongs_to :user

  validates :title, uniqueness: {case_sensitive: false}, presence: true
end
