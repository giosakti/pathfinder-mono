class Deployment < ApplicationRecord
  # Setup transient attributes for your model (attr_accessor)
  # e.g.
  # attr_accessor :temp
  enum statuses: {
    pending: 'PENDING',
    progress: 'PROGRESSING',
    failed: 'FAILED',
    completed: 'COMPLETED',
  }

  # Setup validations for your model
  # e.g.
  # validates_presence_of :name
  # validates_uniqueness_of :name, case_sensitive: false

  # Setup relations to other models
  # e.g.
  # has_one :user
  # has_many :users
  # has_and_belongs_to_many :users
  # has_many :employees, through: :users
  has_many :containers

  #
  # Setup scopes
  #

  #
  # Setup for additional gem-related configuration
  #

  #
  # Setup callbacks & state machines
  #

  #
  # Setup additional methods
  #
end