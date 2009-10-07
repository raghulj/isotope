require 'vendor/plugins/grit/lib/grit'
include Grit

@repos = Repo.new('/home/raghul/Work/btis')
puts @repos

#@repos = Repo.new('/home/raghul/Work/mForms').tree

n = @repos.commits.first
h = n.tree

for i in  h.contents do
    puts i.id
end
puts "------------------"
i = @repos.tree("3ec951746803e8f90e7c76fa05e924dbacc703a9")
puts i.contents 

ss = @repos.blob("a007feab071f496a016f150e1acd8fae57669cce")

puts ss.data
