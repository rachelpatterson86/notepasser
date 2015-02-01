class CreateMessagesTable<ActiveRecord::Migration

  def self.up
    create_table :messages do |t|
    t.integer :recipient_id
    t.text :content
    t.boolean :read_status
    t.belongs_to :users, index: true
    t.datetime :timestamps
    end
  end

  def self.down
    drop_table :messages
  end

end
