class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :content, presence: true

  after_create_commit :broadcast_message
  private

  def broadcast_message
    broadcast_append_to chat, target: "messages_#{chat.id}", partial: "messages/message", locals: { message: self }
  end
end
