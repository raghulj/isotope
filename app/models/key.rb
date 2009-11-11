require 'repoinit'
class Key < ActiveRecord::Base
  include Repoinit
  belongs_to :user
  
  def after_save
    logger.info "Key named #{self.git_name} is added to the repositroy" 
    add_changes_to_conf
  end

  def after_destroy
      logger.info "Keys is destroyed from the db #{self.git_name} destroyed"
      add_changes_to_conf
  end

end
