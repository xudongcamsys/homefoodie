FactoryGirl.define do
  factory :location do
    user nil
    is_geocodable true
    is_visible true
    lat 1.5
    lng 1.5
  end

end
