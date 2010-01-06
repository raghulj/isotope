
# To install a fresh copy of Gitosis server on your machine automatically
# and configure that with this web application. Run this script
#
require 'fileutils'
GITOSIS_CLONE_URL = "git://eagain.net/gitosis.git"
SRC_FOLDER = Dir.pwd.to_s
TMP_FOLDER =  SRC_FOLDER + '/temp'
LOCAL_GIT_FOLDER = TMP_FOLDER + '/gitosis'
# Executes the system command
# If it fails try to execute that again
def exec_cmd(cmd)
  chk = system(cmd)
  system(cmd) unless chk
end

# Removes all the configuration and installation files
def clear_all 
  exec_cmd("sudo rm -rf #{TMP_FOLDER}")
  exec_cmd("sudo userdel git")
  exec_cmd("sudo groupdel git")
  exec_cmd("sudo rm -rf /home/git")
  exec_cmd("rm -rf ~/.ssh/isa_rsa_isotope*")
  exec_cmd("sudo rm -rf #{SRC_FOLDER}/gitosis-admin")
end

clear_all()
puts "*******************************************************************************************************"
puts "* NOTE: you need to be a sudoer to run this script\n* This is only compatible with ubuntu/debian system" 
puts "*******************************************************************************************************"
puts "\n Created a temporary directory"
# create a temporary directory 
exec_cmd("mkdir #{TMP_FOLDER}")

# clone the latest version of git repository from the server to tmp folder
Dir.chdir(TMP_FOLDER)
# Pull the code from the server url
puts " Downloading gitosis server files ... "
exec_cmd("git clone #{GITOSIS_CLONE_URL}")

puts " Installing necessary files need by python. "
exec_cmd("sudo apt-get install python-setuptools")
puts " Installing gitosis to the system.. "
exec_cmd("sudo python setup.py install")
puts "\n Adding user to the system without a password"
exec_cmd("sudo adduser --system --shell /bin/sh --gecos 'git version control' --group --disabled-password --home /home/git git")
puts "\n Created user to system. Generating ssh-key to access the git server"
SSH_FILE  = File.expand_path("~#{ENV['USER']}")+ "/.ssh/isa_rsa_isotope"
exec_cmd("ssh-keygen -t rsa -f #{SSH_FILE}")

# since the ssh filename is diff, we are adding that to the rsa file
exec_cmd("ssh-add #{SSH_FILE}")
# copying the pub file to tmp for permission problems if exists
exec_cmd("cp #{SSH_FILE + ".pub"} /tmp/isa_rsa_isotope.pub")
# not necessary but for safety
exec_cmd("sudo chmod 777 /tmp/isa_rsa_isotope.pub")

puts "\n Adding the ssh key to the server"
exec_cmd("sudo -H -u git gitosis-init <  /tmp/isa_rsa_isotope.pub")

puts "\n Executing persmission problem hook "
exec_cmd("sudo chmod 755 /home/git/repositories/gitosis-admin.git/hooks/post-update")

puts "\n If the installation is successfull, the git-conf should be downloaded to the web app root directory"
# Change the directory to the root for downloading the gitosis configuration
Dir.chdir(SRC_FOLDER)
# add user to group
current_user = ENV['USER']
exec_cmd("useradd -G git #{current_user}")
puts "\n Started downloading the file to the web root .. "
exec_cmd("git clone git@localhost:gitosis-admin.git")
puts "\n Installation is over. Now you should be able to access the repository from the webapp"



