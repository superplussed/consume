Set-up (need to automate):

- Role.create(name: 'admin')
- User.create({:email => "xperts@gmail.com", :password => "11111111", :password_confirmation => "11111111" })
- User.first.roles.push(Role.first)
- Consumer::Scraper.new.cities_list
- Consumer::Scraper.new.job_listings