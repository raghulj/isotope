class CreateRepositories < ActiveRecord::Migration
  def self.up
    create_table :repositories do |t|
      t.string :name
      t.string :repo_name
      t.string :path
      t.text :description
      t.integer :project_id, :options => "CONSTRAINTS fk_projectid REFERENCES projects(id)"
      t.timestamps
    end
  end

  def self.down
    drop_table :repositories
  end
end
