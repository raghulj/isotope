require 'grit'
class SourceController < ApplicationController
    include Grit
   # before_filter :get_repos

            
    @@links = []
    @@repository_id = 0
    def index
        get_repos(params[:repository_id])
        @repos = @reposis.tree
        @repository_id = @@repository_id
        @link = @@links
        render 'index'
    end

    def tree_items
        get_repos(params[:repository_id])
        @repos = @reposis.tree/(params[:id])
        if params[:id]
            @ap_string = params[:id]+"/"
            @crum = @ap_string.split("/")
            @link = @@links
            i=0
            for c in @crum
                @@links << "<a href='/source/tree_items/#{@crum[0..i].join("%2F")}?repository_id=#{@@repository_id}'>#{c}</a>"
                i+=1
            end
        else
            @ap_string =""
        end
        @repository_id = @@repository_id
    end

    def view_file
        get_repos(params[:repository_id])
        @link = @@links
        puts @link
        @data = @reposis.blob(params[:id])
        puts @data
        @repository_id = @@repository_id
    end
    

    def get_repos(repo_id)
        @@repository_id = repo_id
        @re = Repository.find(repo_id)
        @@links << "<a href='/source?repository_id=#{repo_id}'>#{@re.name}</a>"
        @reposis = Repo.new(@re.path)
    end

end
