class User < ActiveRecord::Base
    has_many :memberships
    has_many :projects, :through => :memberships
    has_many :keys
    has_many :snippets
    has_one :roles, :through => :role_users
    has_many :role_users
    has_many :gtds
    has_many :chirps
    acts_as_authentic

    attr :role
  
  def has_role(role_name)
      @r = Role.find_or_create_by_role(role_name)
      @r.save!
      @rol_user = RoleUser.new(:role_id => @r.id, :user_id => self.id)
      @rol_user.save!
  end

  def has_role? (role)
    if self.roles.role ==  role
        return true
    else
        return false
    end
  end


end
