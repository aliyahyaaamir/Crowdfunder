class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :projects
  attr_accessible :first_name, :last_name, :email, :password
  validates_presence_of :password, :on =>  :create
  validates :first_name, :last_name, :email, :presence => true
  has_many :pledges
end
