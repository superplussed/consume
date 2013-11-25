module AdminConfig::JobListing
  def admin_block
    Proc.new {
      rails_admin do
        list do
          filters [:title, :city, :error].sort{|x,y| x<=>y}
          sort_by :id
          field :id, :link_to_edit do
            sort_reverse true
          end
          field :title
          field :city
          field :url
        end
      end
    }
  end
end