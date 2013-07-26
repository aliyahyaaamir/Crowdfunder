class Project < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :goal, :teaser, :title, :user_id
  validates :description, :teaser, :title, :presence => true
  has_many :pledges
end
