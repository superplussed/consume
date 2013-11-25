module Search::JobListingMapping

  def search_block
    Proc.new do
      tire.mapping do
        indexes :title, :type => 'string', :boost => 100, :analyzer => 'snowball'
        indexes :body, :type => 'string', analyzer: 'snowball', boost: 20
        indexes :compensation, :type => 'string', analyzer: 'snowball', boost: 2

        indexes :subdomain, analyzer: 'keyword'
        indexes :url, analyzer: 'keyword'
        indexes :remote, analyzer: 'keyword'
        indexes :email, analyzer: 'keyword'
        indexes :posted_at, type: 'date'
        indexes :id, type: 'keyword'
      end

      after_save do
        update_index
      end
    end
  end

  def query query_string, params = {}
    @query_string, @params = format_query_string(query_string), params
    JobListing.search do |search|
      search.query do |query|
        query.string @query_string
      end
    end
  end

  def index_all
    ::JobListing.unscoped.index.delete
    ::JobListing.unscoped.index.import(JobListing.unscoped.all)
  end

  def index_subset job_listings
    ::JobListing.unscoped.index.import(job_listings)
  end
end
