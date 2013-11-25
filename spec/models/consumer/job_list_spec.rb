require 'spec_helper'

describe Consumer::JobList, sidekiq: :inline do

  describe "#scrape" do

    let (:job_list_1_job) { JobListHelper.fetch("job_list_1_job")}
    let (:job_list_2_jobs) { JobListHelper.fetch("job_list_2_jobs")}
    let (:bad_url) { JobListHelper.fetch("bad_url")}

    describe "Error-free HTML files" do

      before (:each) { 
        job_list_1_job.scrape
      }

      it "should create JobListing entries" do
        JobListing.count.should == 1
      end

      it "should create a job for scraping the listing content" do
        JobListing.first.body.should_not be_nil
      end
    end

    describe "Non-existant file URL" do

      it "should add error message to city" do
        bad_url.scrape
        City.first.error_logs.count.should == 1
      end

      it "should not raise an exception" do
        expect {
          bad_url.scrape
        }.to_not raise_exception
      end
    end

  #   describe "Errors in HTML files" do

  #     before(:each) { job_list_2_jobs.scrape }
      
  #     it "should scrape the correct number of pages" do
  #       JobListing.count.should == 2
  #     end

  #     it "should show error on one job" do
  #       JobListing.where(error: true).count.should == 1
  #     end

  #     it "should continue scraping the other job" do
  #       JobListing.where(error: false).not(body: nil).count.should == 1
  #     end
  #   end
  end


end