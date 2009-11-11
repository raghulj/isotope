class AddUniqidSnippets < ActiveRecord::Migration
  def self.up
    add_column :snippets, :uniq_id, :uniq => true
  end

  def self.down
      remove_column :snippets, :uniq_id
  end

end
