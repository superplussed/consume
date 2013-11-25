class ErrorLog < ActiveRecord::Base
  extend AdminConfig::ErrorLog

  belongs_to :loggable, polymorphic: true

  attr_accessible :message

  admin_block.call(rails_admin)
end