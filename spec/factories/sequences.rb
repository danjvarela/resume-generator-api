FactoryBot.define do
  sequence(:company_name) { |n| "Company #{n}" }
  sequence(:job_title) { |n| "Job #{n}" }
  sequence(:city) { |n| "City #{n}" }
  sequence(:resume_title) { |n| "Resume #{n}" }
  sequence(:skill_name) { |n| "Skill #{n}" }
  sequence(:user_name) { |n| "User #{n}" }
  sequence(:school_name) { |n| "School #{n}" }
end
