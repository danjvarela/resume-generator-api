class Resume < ApplicationRecord
  belongs_to :user

  validates :title, uniqueness: {case_sensitive: false, scope: :user_id}, presence: true
end
