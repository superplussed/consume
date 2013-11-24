# require 'spec_helper'

# describe Consumer::Node do

#   context "Flat Tag" do
#     let(:html) do
#       Nokogiri.HTML <<-EOHTML
#       <body>
#         <h1>Foo</h1>
#       </body>
#       EOHTML
#     end

#     Given(:nokogiri_node){html.at_css("h1")}
#     When(:node){Consumer::Node.new(nokogiri_node)}
#     Then{node.text.should == nil}
#     Then{node.children.map(&:text).include?("Foo")}
#     Then{node.html.should == "<h1>Foo</h1>"}
#   end

#   context "Embedded Tags" do
#     let(:html) do
#       Nokogiri.HTML <<-EOHTML
#       <body>
#         <p>
#           <h1>Foo</h1>
#         </p>
#       </body>
#       EOHTML
#     end

#     Given(:nokogiri_node){html.at_css("p")}
#     When(:node){Consumer::Node.new(nokogiri_node)}
#     Then{node.text.should == nil}
#   end

# end