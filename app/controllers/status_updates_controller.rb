class StatusUpdatesController < ApplicationController
  before_action :authenticate_user!

  def new
    @status_update = StatusUpdate.new
  end

 def create
    @status_update = StatusUpdate.new(status_update_params)

    @conversation_item = ConversationItem.new(author: current_user, item: @status_update)

    respond_to do |format|
      if @conversation_item.save
        format.html { redirect_to root_url, notice: "Project status was successfully updated." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def status_update_params
    params.require(:status_update).permit(:status)
  end
end
