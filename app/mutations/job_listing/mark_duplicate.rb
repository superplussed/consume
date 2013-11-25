class JobListing::MarkDuplicate < Mutations::Command

  required do
    model :job_listing
  end

  def execute
    job_listing.update_attributes(duplicate: true)
  end
end
