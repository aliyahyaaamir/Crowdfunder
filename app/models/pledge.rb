class Pledge < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  attr_accessible :amount, :user_id, :project_id
  validates :user, :project, :presence => true
  validates :amount, :numericality => { :greater_than => 0}
end
