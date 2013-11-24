class CityWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly.minute_of_hour(0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55) }

  def perform 
    city = CityList.next_in_queue
    p "city: #{city.name}"
    city.scrape_job_listings
  end
end