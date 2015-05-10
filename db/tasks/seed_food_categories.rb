# preferences
['Vegetarian', 'Vegan', 'Meat', 'Dairy', 'Other'].each do | pref |
  FoodPreference.where(name: pref).first_or_create
end

# types
['Breakfast', 'Appetizer', 'Entree', 'Dessert', 'Other'].each do | pref |
  FoodType.where(name: pref).first_or_create
end

# preferences
['Chinese', 'French', 'Italian', 'American', 'Other'].each do | pref |
  Cuisine.where(name: pref).first_or_create
end