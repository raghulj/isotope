class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :title
      t.text :body
      t.integer :project_id , :options => "CONSTRAINTS fk_projectid REFERENCES projects(id)"
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
