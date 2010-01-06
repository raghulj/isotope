class AddStatusToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :status, :string
  end

  def self.down
    remove_column :tickets, :status
  end
end
