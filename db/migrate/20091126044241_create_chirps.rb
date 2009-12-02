class CreateChirps < ActiveRecord::Migration
  def self.up
    create_table :chirps do |t|
      t.text :message
      t.boolean :aloud
      t.boolean :sms
      t.integer :user_id, :conditions => "fk_userid REFERENCES users(id)"
      t.timestamps
    end
  end

  def self.down
    drop_table :chirps
  end
end
