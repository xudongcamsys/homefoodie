json.array!(@dishes) do |dish|
  json.extract! dish, :id
  json.url dish_url(dish, format: :json)
end
