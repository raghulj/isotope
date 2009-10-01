require 'grit'
class SourceController < ApplicationController
    include Grit
    def index
        @repos = Repo.new('/home/raghul/Work/mForms').tree

    end
end
