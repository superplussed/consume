module AdminConfig::City
  def admin_block
    Proc.new {
      rails_admin do
        list do
          filters [:last_scrape_started_at, :last_scrape_ended_at, :name].sort{|x,y| x<=>y}
          sort_by :id
          field :id, :link_to_edit do
            sort_reverse true
          end
          field :name
          field :subdomain
          field :skip
          field :last_scrape_started_at
          field :last_scrape_ended_at
        end
        show do
          field :id
          field :skip
          field :name
          field :subdomain
          field :last_scrape_started_at
          field :last_scrape_ended_at
          field :job_listings
          field :urls 
        end
      end
    }
  end
end