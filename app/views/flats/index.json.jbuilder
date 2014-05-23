json.array!(@flats) do |flat|
  json.extract! flat, :id, :name, :address
  json.url flat_url(flat, format: :json)
end
