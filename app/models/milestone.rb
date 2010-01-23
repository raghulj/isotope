class Milestone < ActiveRecord::Base
  has_many :tickets
  belongs_to :project
end
