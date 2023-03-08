require 'rails_helper'

RSpec.describe StatusUpdate, type: :model do
  subject { build :status_update }

  describe 'validations' do
    it { is_expected.to validate_presence_of :status }
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

  context 'when multiple status updates have been persisted' do
    let!(:first_update) do
      create(:conversation_item, with_item: create(:status_update, :proposed)).item
    end

    let!(:second_update) do
      create(:conversation_item, with_item: create(:status_update, :planned)).item
    end

    let!(:third_update) do
      create(:conversation_item, with_item: create(:status_update, :early_development)).item
    end

    describe 'first status update' do
      subject { first_update }

      it 'does not have a previous status' do
        expect(subject.previous_status).to be_nil
      end

      it 'does not have a previous status update' do
        expect(subject.previous_status).to be_nil
      end
    end

    describe 'any status update but the first' do
      subject { third_update }

      it 'can access the previous status' do
        expect(subject.previous_status).to eq second_update.status
      end

      it 'can access the previous status update' do
        expect(subject.previous_status_update).to eq second_update
      end
    end

    describe '#current' do
      it 'returns the latest status update' do
        expect(described_class.current).to eq third_update
      end
    end
  end

  context 'when there is no status update yet' do
    describe '#current' do
      it 'returns nil' do
        expect(described_class.current).to be_nil
      end
    end
  end
end
