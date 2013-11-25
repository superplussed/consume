class ErrorLog < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true

  attr_accessible :message
end