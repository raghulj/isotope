class AddAssignedToInTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :user_id, :integer, :options => "CONSTRAINTS fk_user_id REFERENCES users(id)"
    #add_column :tickets, :milestone_id, :integer, :options => "CONSTRAINTS fk_milestone_id REFERENCES milestones(id)"
  end

  def self.down
    remove_column :tickets, :user_id
  end
end
