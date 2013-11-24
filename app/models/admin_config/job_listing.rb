module AdminConfig::JobListing
  def admin_block
    Proc.new {
      rails_admin do
        list do
          sort_by :id
          field :id, :link_to_edit do
            sort_reverse true
          end
          field :title
          field :url
          field :error
          field :error_message
        end
      end
    }
  end
end