class CreateSnippets < ActiveRecord::Migration
  def self.up
    create_table :snippets do |t|
      t.text :snippet
      t.boolean :view
      t.integer :user_id, :options => "CONSTRAINTS fk_userid references users(id)"
      t.timestamps
    end
  end

  def self.down
    drop_table :snippets
  end
end
