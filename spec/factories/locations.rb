FactoryGirl.define do
  factory :location do
    user nil
    is_geocodable false
    is_visible false
    lat 1.5
    lng 1.5
  end

end
