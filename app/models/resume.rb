class Resume < ApplicationRecord
  after_create_commit -> { broadcast_resume("create") }
  after_destroy_commit -> { broadcast_resume("destroy") }
  after_update_commit -> { broadcast_resume("update") }

  belongs_to :user

  validates :title, uniqueness: {case_sensitive: false, scope: :user_id}, presence: true

  private

  def broadcast_resume(action)
    ActionCable.server.broadcast("ResumesChannel", ResumeSerializer.new(self).as_json.merge({action: action}))
  end
end
