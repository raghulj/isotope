class AddMilestoneIdToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :milestone_id, :integer, :conditions => "CONSTRAINTS fk_milestone_id REFERENCES milestones(id)", :default => 0
  end

  def self.down
    remove_column :tickets, :milestone_id
  end
end
