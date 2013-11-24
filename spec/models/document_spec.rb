require 'spec_helper'

describe Document do

  let(:basic) { Document.new("#{Rails.root}/spec/pages/craigslist/job_listing.html") }
  let(:chartbeat) { Document.new("http://chartbeat.com/jobs") }
  let(:google) { Document.new("http://www.google.com") }

  describe "#root" do
    it "should return a local page" do
      basic.root.class.name.should eq("Nokogiri::HTML::Document")
    end

    it "should return a remote page" do
      google.root.class.name.should eq("Nokogiri::HTML::Document")
    end
  end

end
