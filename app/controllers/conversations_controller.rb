class ConversationsController < ApplicationController
  before_filter :authenticate_user!, :mailbox
  before_filter :conversation, except: [:index, :new, :create]

  def create
    recipient_ids = conversation_params[:recipients].split(',')
    recipients = User.where(id: recipient_ids).all

    conversation = current_user.
      send_message(recipients, conversation_params[:body], conversation_params[:subject]).conversation

    redirect_to conversation_path(conversation)
  end

  def show

    # mark as read
    current_user.mark_as_read @conversation
  end

  def reply
    current_user.reply_to_conversation(conversation, message_params[:body], message_params[:subject])
    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end

  def conversation_params
    params.require(:conversation).permit(:recipients, :subject, :body)
  end

  def message_params
    params.require(:message).permit(:subject, :body)
  end

end