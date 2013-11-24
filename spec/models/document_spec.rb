require 'spec_helper'

describe Consumer::Document do

  let(:basic) { Consumer::Document.new("#{Rails.root}/spec/sites/test/index.html") }
  let(:chartbeat) { Consumer::Document.new("http://chartbeat.com/jobs") }
  let(:google) { Consumer::Document.new("http://www.google.com") }

  describe "#root" do
    it "should return a local page" do
      basic.root.class.name.should eq("Nokogiri::HTML::Document")
    end

    it "should return a remote page" do
      google.root.class.name.should eq("Nokogiri::HTML::Document")
    end
  end

  describe "#children" do
    it "should return the array of children" do
      chartbeat.children.count.should > 0
    end
  end
end
