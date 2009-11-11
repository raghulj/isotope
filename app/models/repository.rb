require 'repoinit'
class Repository < ActiveRecord::Base
  include Repoinit
  belongs_to :project
  has_one :source 
  def after_save
    logger.info "repo model  afer sace" 
    add_changes_to_conf
  end

  def after_destroy
      logger.info "Repository #{self.name} destroyed"
      add_changes_to_conf
  end
end
