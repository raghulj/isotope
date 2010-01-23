class CreateMilestones < ActiveRecord::Migration
  def self.up
    create_table :milestones do |t|
      t.date :due_date
      t.string :title
      t.integer :assigned_to, :conditions => "CONSTRIANTS fk_user_id REFERENCES users(id)"
      t.integer :project_id, :conditions => "CONSTRAINTS fk_project_id REFERENCES projects(id)"

      t.timestamps
    end
  end

  def self.down
    drop_table :milestones
  end
end
