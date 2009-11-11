class AddUserIdToGtd < ActiveRecord::Migration
  def self.up
      add_column :gtds, :user_id, :integer, :options => "CONSTRAINTS fk_userid REFERENCES users(id)"
  end

  def self.down
      remove_column :gtds, :user_id
  end
end
