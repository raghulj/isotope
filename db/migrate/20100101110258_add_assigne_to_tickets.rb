class AddAssigneToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :assigne, :integer, :options => "CONSTRAINTS fk_user_id REFERENCES users(id)"
  end

  def self.down
    remove_column :tickets, :assigne
  end
end
