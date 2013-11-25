module AdminConfig::ErrorLog
  def admin_block
    Proc.new {
      rails_admin do
        list do
          field :created_at
          field :message
          field :loggable
        end
      end
    }
  end
end