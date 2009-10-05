require 'repoinit'
class Repository < ActiveRecord::Base
    include Repoinit
  belongs_to :project
 
end
