namespace :scrape do
  desc "Scrape new job listings"
  task :job_listings => :environment do
    Consumer::Scraper.new.job_listings
  end
end

