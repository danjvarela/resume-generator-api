class ResumesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ResumesChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
