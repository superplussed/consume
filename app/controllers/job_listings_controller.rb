class JobListingsController < ApplicationController
  expose(:job_listing) {JobListing.find(params[:id])}
  expose(:job_listings) {JobListing.for_display.order(posted_at: :desc).page(page)}
  expose(:count) {JobListing.for_display.count}

  def update
    respond_to do |format|
      if job_listing.update(job_listing_params)
        format.html { redirect_to @job_listing, notice: 'Job listing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @job_listing.errors, status: :unprocessable_entity }
      end
    end
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
