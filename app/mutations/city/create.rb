class City::Create < Mutations::Command

  required do
    string :subdomain
    string :name
    string :state
    string :country
  end

  def execute
    unless City.find_by_name_and_state_and_country(name, state, country)
      City.create!(inputs)
    end
  end
end