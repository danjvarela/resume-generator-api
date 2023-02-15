class Job < ApplicationRecord
  belongs_to :company
  belongs_to :user
  validates :title, presence: true, uniqueness: {case_sensitive: false}
  validates :start_date, presence: true, past_date: true
  validates :end_date, past_date: true
end
