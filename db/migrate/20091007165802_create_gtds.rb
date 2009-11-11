class CreateGtds < ActiveRecord::Migration
  def self.up
    create_table :gtds do |t|
      t.string :name
      t.date :due_on
      t.text :description
      t.string :priority
      t.boolean :done

      t.timestamps
    end
  end

  def self.down
    drop_table :gtds
  end
end
