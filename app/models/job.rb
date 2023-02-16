class Job < ApplicationRecord
  before_validation :create_company_if_not_exists

  attr_accessor :company_name

  belongs_to :company
  belongs_to :user
  validates :title, presence: true, uniqueness: {case_sensitive: false}
  validates :start_date, presence: true, past_date: true
  validates :end_date, past_date: true

  private

  def create_company_if_not_exists
    return unless company_id.blank? && company.blank?
    self.company = Company.find_by name: company_name
    self.company ||= Company.create name: company_name unless company_name.blank?
  end
end
