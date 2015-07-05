FactoryGirl.define do
  factory :event do
    name 'test event'
    description 'event description'
    organizer nil
    event_address nil
    scheduled_at Date.today
  end

end
