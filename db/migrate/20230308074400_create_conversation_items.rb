class CreateConversationItems < ActiveRecord::Migration[7.0]
  def change
    create_table :conversation_items do |t|
      t.belongs_to :author, null: false, foreign_key: { to_table: :users }
      t.references :item, polymorphic: true

      t.timestamps
    end
  end
end
