require File.dirname(__FILE__) + '/../spec_helper'

describe Link do
  describe "localhost/page" do
    Given (:link) { Link.new("localhost/page") }
    Then  { link.root !=~ /page/  }
    And  { link.host == "localhost" }
    And  { link.secure? == false }
  end

  describe "remote.com/page" do
    Given (:link) { Link.new("remote.com/page")}
    Then  { link.url =~ /http/ }
    And  { link.secure? == false }
  end

  describe "remote.com/page?querystring" do
    Given (:link) { Link.new("remote.com/page?querystring")}
    Then  { link.full =~ /\?querystring/ }
  end
end