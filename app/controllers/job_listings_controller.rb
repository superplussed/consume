class JobListingsController < ApplicationController
  expose(:job_listing)
  expose(:job_listings) {JobListing.where(:body.ne => nil).sort(:posted_at.desc)}

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
    # Never trust parameters from the scary internet, only allow the white list through.
    def job_listing_params
      params.require(:job_listing).permit(:title, :body, :posted_at, :email, :url)
    end
end
