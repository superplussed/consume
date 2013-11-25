class ErrorLogAssociation < ActiveRecord::Base
  belongs_to :error_log
  belongs_to :target, polymorphic: true

  attr_accessible :error_log_id, :target_id
end