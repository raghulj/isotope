class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :short_summary
      t.text :description
      t.date :due_date
      t.text :priority
      t.text :severity
      t.integer :hours
      t.integer :project_id , :options => "CONSTRAINTS fk_projectid REFERENCES projects(id)"
      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
