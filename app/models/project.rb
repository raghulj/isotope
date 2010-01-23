class Project < ActiveRecord::Base
    has_many :messages
    has_many :tickets
    has_many :milestones
    has_many :repositories
    has_many :todos
    has_many :memberships, :dependent => :destroy
    has_many :users, :through => :memberships, :uniq => true
end
