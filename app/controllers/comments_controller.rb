class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    @conversation_item = ConversationItem.new(author: current_user, item: @comment)

    respond_to do |format|
      if @conversation_item.save
        format.html { redirect_to root_url, notice: "Comment was successfully posted." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
