class JobListingsController < ApplicationController
  expose(:job_listing)
  expose(:job_listings) do
    if params["query"]
      JobListing.search(params["query"])
    else
      JobListing.for_display.order(posted_at: :desc).page(page)
    end
  end
  expose(:count) {JobListing.for_display.count}

  def index

  end

  def scrape
    job_listing.scrape
    redirect_to job_listing
  end

  def destroy
    job_listing.destroy
    respond_to do |format|
      format.html { redirect_to job_listings_url }
      format.json { head :no_content }
    end
  end

private

  def job_listing_params
    params.require(:job_listing).permit(:title, :body, :posted_at, :email, :url)
  end
end
