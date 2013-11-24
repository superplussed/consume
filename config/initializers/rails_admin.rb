# Dir["#{Rails.root}/lib/rails_admin/config/actions/*.rb"].each {|file| require file }
# Dir["#{Rails.root}/lib/rails_admin/config/fields/*.rb"].each {|file| require file }
require "#{Rails.root}/lib/rails_admin/config/fields/types/link_to_edit"
require "#{Rails.root}/lib/rails_admin/config/actions/scrape"

RailsAdmin.config do |config|

  config.yell_for_non_accessible_fields = false
  config.main_app_name = ['CONSUME Admin']
  config.main_app_name.push(Rails.env) unless Rails.env == "production"
  config.current_user_method { current_user }
  config.authorize_with :cancan
  config.audit_with :history, User
  config.total_columns_width = 1400
  config.compact_show_view = false

  config.actions do
    config.actions do
      dashboard do
        statistics false
        pjax false
      end
      index 
      new 
      export 
      history_index 
      bulk_delete
      # member actions
      edit 
      show 
      history_show 
      delete 
      show_in_app 
      scrape
    end
  end
end