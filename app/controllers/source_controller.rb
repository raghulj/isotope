require 'grit'
class SourceController < ApplicationController
    include Grit
    before_filter :get_repos

            
    @@links = []
    def index
        get_repos(params[:id])
        @repos = @reposis.tree
        render 'index'
    end

    def tree_items
        @repos = @reposis.tree/(params[:id])
        if params[:id]
            @ap_string = params[:id]+"/"
            @crum = @ap_string.split("/")
            @link = @@links
            i=0
            for c in @crum
                @@links << "<a href='/source/tree_items/#{@crum[0..i].join("%2F")}'>#{c}</a>"
                i+=1
            end
        else
            @ap_string =""
        end
    end

    def view_file
        @link = @@links
        @data = @reposis.blob(params[:id])
    end
    

    def get_repos(repo_id)
        @re = Repository.find(repo_id)
        @reposis = Repo.new(@re.path)
    end

end
