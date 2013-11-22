module MassAssignment
  extend ActiveSupport::Concern

  def initialize(attributes = {})
      set_attributes(attributes)
      super
    end

  def set_attributes(attributes)
    attributes.each do |attr,value|
      self.send("#{attr}=", value) if self.respond_to?("#{attr}=")
    end
  end

end