class CreateRoleUsers < ActiveRecord::Migration
  def self.up
    create_table :role_users do |t|
      t.integer :user_id, :options => "CONSTRAINTS fk_userid REFERENCES users(id)"
      t.integer :role_id, :options => "CONSTRAINTS fk_roleid REFERENCES roles(id)"
      t.timestamps
    end
  end

  def self.down
    drop_table :role_users
  end
end
