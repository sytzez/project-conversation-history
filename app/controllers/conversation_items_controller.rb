class ConversationItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversation_items = ConversationItem.all
  end
end
