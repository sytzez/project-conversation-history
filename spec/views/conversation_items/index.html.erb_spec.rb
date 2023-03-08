require 'rails_helper'

RSpec.describe "conversation_items/index", type: :view do
  # before(:each) do
  #   assign(:conversation_items, [
  #     ConversationItem.create!(
  #       author: nil
  #     ),
  #     ConversationItem.create!(
  #       author: nil
  #     )
  #   ])
  # end
  #
  # it "renders a list of conversation_items" do
  #   render
  #   cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  #   assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  # end

  context 'when there are no conversation items' do
    before(:each) do
      assign(:conversation_items, [])
      assign(:current_status, nil)
    end

    it 'does not show the current project status' do
      render
      expect(rendered).not_to match /Current project status:/
    end
  end

  context 'when there are conversation items' do
    let(:first_status_update) { create(:status_update, :proposed) }
    let(:comment) { create(:comment) }
    let(:second_status_update) { create(:status_update, :planned) }

    let(:conversation_items) do
      [
        create(:conversation_item, with_item: second_status_update),
        create(:conversation_item, with_item: comment),
        create(:conversation_item, with_item: first_status_update),
      ]
    end

    let(:current_status) do
      second_status_update.status.humanize
    end

    before(:each) do
      assign(:conversation_items, conversation_items)
      assign(:current_status, current_status)
    end

    it 'shows the current project status' do
      render
      expect(rendered).to match /Current project status:/
      expect(rendered).to match /<h1>Planned<\/h1>/
    end

    it 'shows all author emails' do
      render

      conversation_items.each do |item|
        expect(rendered).to include item.author.email
      end
    end

    it 'shows the comment content' do
      render

      expect(rendered).to include comment.content
    end
  end
end
