require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class Scrape < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member? do
          true
        end

        register_instance_option :link_icon do
          'icon-wrench'
        end

        register_instance_option :pjax? do
          false
        end

        register_instance_option :controller do
          Proc.new do
            @object.scrape
            redirect_to back_or_index
          end
        end
      end
    end
  end
end