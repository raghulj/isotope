module Repoinit
    #On each repository or user is added is to the repository
    # the gitosis.conf file is to be created to add new git repo
    # to the system. This is invoked for creating the file each time
    
   SYSADMIN = "raghul@alabaster"
      
  # cloned path of the gitosis-admin directory
  GITOSIS_ADMIN_LOCAL_PATH = RAILS_ROOT+'/gitosis-admin'

  # create a file with the name self.git_name into the keydir of the local repo gitosis-admin
  def add_key_to_git
      path =GITOSIS_ADMIN_LOCAL_PATH + "/keydir/" + self.git_name.to_s+".pub"  
      puts path
      File.open(path,'w'){ |f| f.write(self.value)}
      apply_changes("Added #{self.git_name.to_s}.pub file to the repos")
  end

  # delete the key from the repos
  def delete_key_from_git
      cmd = `rm -rf #{GITOSIS_ADMIN_LOCAL_PATH}/keydir/#{self.git_name.to_s}.pub`
      logger.info "Deleting pub file from the git repo"+cmd.to_s
      apply_changes("removed file#{self.git_name.to_s}.pub")
  end

  # Adding data to git
  def add_to_git
      cmd = `git --git-dir=#{GITOSIS_ADMIN_LOCAL_PATH}/.git --work-tree=#{GITOSIS_ADMIN_LOCAL_PATH} add .`
      logger.info "Added changes to gitosis-admin in keys"
  end

  # commits the gitosis-admin repo
  def commit(mess)
      logger.info mess
      cmd = `git --git-dir=#{GITOSIS_ADMIN_LOCAL_PATH}/.git --work-tree=#{GITOSIS_ADMIN_LOCAL_PATH} commit -am "#{mess}"`
      logger.info cmd
  end

  # push the changes made to the git repo
  def push
      logger.info "pushing changes to git "
      cmd = `git --git-dir=#{GITOSIS_ADMIN_LOCAL_PATH}/.git --work-tree=#{GITOSIS_ADMIN_LOCAL_PATH} push`
      logger.info cmd
  end

  # this adds,commit and push the changes to the git repo
  def apply_changes(mess)
      path = GITOSIS_ADMIN_LOCAL_PATH+"/gitosis.conf"
      File.open(path,'w'){ |f| f.write(create_repos)}
      add_to_git
      commit(mess)
      push
  end


  def add_changes_to_conf
      apply_changes("May be a repository s added")
  end
  
  def create_repos
        data = "[gitosis]\n\n"
        data += "[group gitosis-admin]\nwritable = gitosis-admin\n"
        data += "members = "+SYSADMIN+"\n\n"
        pro = Project.all
        for p in pro do
            usr = ""
            key = p.users.collect { |k| k.keys }.flatten
            for user in key do
                usr += " "+user.git_name
            end
            puts usr
            repo = p.repositories
            for r in repo do
                re = "[group "+r.repo_name+"]\n"
                re+= "writable = "+r.repo_name+"\n"
                re+= "members = "+usr+" "+SYSADMIN+"\n\n"
                data += re
            end
        end
        data 
  end
end

class Tester
    include Repoinit
    def init
        
    end

    def printt
        t = create_repos
        puts t
    end
end
