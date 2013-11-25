module AdminConfig::Settings
  def admin_block
    Proc.new {
      rails_admin do
       
      end
    }
  end
end