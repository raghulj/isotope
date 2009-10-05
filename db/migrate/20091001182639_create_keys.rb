class CreateKeys < ActiveRecord::Migration
  def self.up
    create_table :keys do |t|
      t.string :title
      t.text :value
      t.string :git_name
      t.integer :user_id, :options => "CONSTRIANTS fk_userid REFERENCES users(id)"
      t.timestamps
    end
  end

  def self.down
    drop_table :keys
  end
end
