module AdminConfig::City
  def admin_block
    Proc.new {
      rails_admin do
        list do
          sort_by :id
          field :id, :link_to_edit do
            sort_reverse true
          end
          field :name
          field :subdomain
          field :last_scraped_at
        end
      end
    }
  end
end