require File.dirname(__FILE__) + '/../spec_helper'

describe Link do
  describe "localhost/extension" do
    Given (:link) { Link.new("localhost/extension") }
    Then  { link.root !=~ /extension/  }
    And  { link.host == "localhost" }
    And  { link.secure? == false }
  end

  describe "remote.com/extension" do
    Given (:link) { Link.new("remote.com/extension")}
    Then  { link.url =~ /http/ }
    And  { link.secure? == false }
  end
end