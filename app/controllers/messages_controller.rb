class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.build(message_params.merge(user: current_user))
    if @message.save
      broadcast_append_to @chat
      head :ok
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
