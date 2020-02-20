class ConversationsController < ApplicationController  
  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index, :sent, :trash]
  
  skip_authorization_check
  
  def index
    @conversations = @mailbox.inbox.page(params[:page]).per(10)
  end
  
  def show
    @conversation.mark_as_read(current_user)
  end
  
  def destroy
    @conversation.move_to_trash(current_user)
    
    respond_to do |format|
      format.js {}
    end
  end
  
  def sent
    @conversations = @mailbox.sentbox.page(params[:page]).per(10)
  end
  
  def trash
    @conversations = @mailbox.trash.page(params[:page]).per(10)
  end
  
  def reply
    @receipt = current_user.reply_to_conversation(@conversation, params[:reply][:body])
    
    respond_to do |format|
      format.js {}
    end
  end

  private
  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end
end
