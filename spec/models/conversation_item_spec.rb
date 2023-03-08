require 'rails_helper'

RSpec.describe ConversationItem, type: :model do
  subject { build :conversation_item, :comment }

  describe 'associations' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:item) }
  end

  describe 'scopes' do
    describe 'latest_first' do
      context 'when no conversation items have been persisted' do
        it 'returns an empty result' do
          expect(described_class.latest_first).to be_empty
        end
      end

      context 'when different kinds of conversation items have been persisted' do
        let!(:first_item) { create :conversation_item, :comment }
        let!(:second_item) { create :conversation_item, :status_update }
        let!(:third_item) { create :conversation_item, :comment }

        it 'returns the items in descending order of creation' do
          expect(described_class.latest_first).to eq [third_item, second_item, first_item]
        end
      end
    end
  end
end
