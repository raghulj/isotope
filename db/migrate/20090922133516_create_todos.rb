class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.string :title
      t.text :body
      t.string :type
      t.integer :project_id , :options => "CONSTRAINTS fk_projectid REFERENCES projects(id)" 
      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
