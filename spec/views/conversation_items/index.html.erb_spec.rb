require 'rails_helper'

RSpec.describe "conversation_items/index", type: :view do
  before(:each) do
    assign(:conversation_items, [
      ConversationItem.create!(
        author: nil
      ),
      ConversationItem.create!(
        author: nil
      )
    ])
  end

  it "renders a list of conversation_items" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
