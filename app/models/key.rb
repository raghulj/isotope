require 'repoinit'
class Key < ActiveRecord::Base
  include Repoinit
  belongs_to :user
end
