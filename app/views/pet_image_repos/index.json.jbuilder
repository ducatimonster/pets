json.array!(@pet_image_repos) do |pet_image_repo|
  json.extract! pet_image_repo, :id, :pet_id, :comment
  json.url pet_image_repo_url(pet_image_repo, format: :json)
end
