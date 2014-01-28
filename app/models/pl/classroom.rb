module Pl
  class Classroom < ActiveRecord::Base
    attr_accessible :title, :description, :privacy

    belongs_to :course
  end
end
