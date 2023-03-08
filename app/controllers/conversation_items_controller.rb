class ConversationItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversation_items = ConversationItem.latest_first

    @current_status = StatusUpdate.current&.status&.humanize
  end
end
