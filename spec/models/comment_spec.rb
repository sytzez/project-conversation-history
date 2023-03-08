require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build :comment }

  describe 'validations' do
    it { is_expected.to validate_presence_of :content }
  end

  describe 'associations' do
    it { is_expected.to have_one(:conversation_item) }
  end

  context 'when it has been persisted as part of a conversation item' do
    let(:conversation_item) { create :conversation_item, :status_update }
    let(:status_update) { conversation_item.item }

    describe 'created_at' do
      subject { status_update.created_at }

      it { is_expected.to be_present }

      it { is_expected.to eq conversation_item.created_at }
    end

    describe 'author' do
      subject { status_update.author }

      it { is_expected.to eq conversation_item.author }
    end
  end
end
