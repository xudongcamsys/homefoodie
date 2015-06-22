require 'rails_helper'

RSpec.describe Event, type: :model do
  
  context "find events by attendee name" do 

    it "should return events with participants matching name" do 
      # Event, UserEvent, User
      organizer = create(:user, name: 'event organizer')
      first_participant = create(:user, name: 'first participant')
      second_participant = create(:user, name: 'second participant')
      event = create(:event, organizer: organizer)
      create(:user_event, event: event, participant: first_participant) 
      create(:user_event, event: event, participant: second_participant) 

      events = Event.find_events_by_attendee_name('first') 

      expect(events).to eq([event]) 
    end

    it "should return events with organizer matching name" do 
      # Event, UserEvent, User
      organizer = create(:user, name: 'event organizer')
      first_participant = create(:user, name: 'first participant')
      second_participant = create(:user, name: 'second participant')
      event = create(:event, organizer: organizer)
      create(:user_event, event: event, participant: first_participant) 
      create(:user_event, event: event, participant: second_participant) 

      events = Event.find_events_by_attendee_name('organizer') 

      expect(events).to eq([event]) 
    end

    it "should return events with orginizer or participants matching name" do 
      first_organizer = create(:user, name: 'organizer one')
      second_organizer = create(:user, name: 'organizer two')

      organizer_only_event = create(:event, organizer: first_organizer)
      second_event = create(:event, organizer: second_organizer)
      
      create(:user_event, event: second_event, participant: first_organizer) 

      events = Event.find_events_by_attendee_name('organizer one') 

      expect(events).to eq([second_event, organizer_only_event]) 
    end

    it "should return unique events with multiple match participants" do 
      # Event, UserEvent, User
      organizer = create(:user, name: 'event organizer')
      first_participant = create(:user, name: 'first participant')
      second_participant = create(:user, name: 'second participant')
      event = create(:event, organizer: organizer)
      create(:user_event, event: event, participant: first_participant) 
      create(:user_event, event: event, participant: second_participant) 

      events = Event.find_events_by_attendee_name('participant') 

      expect(events).to eq([event]) 
    end

    it "should return no events without participants matching name" do 
      # Event, UserEvent, User
      organizer = create(:user, name: 'event organizer')
      first_participant = create(:user, name: 'first participant')
      second_participant = create(:user, name: 'second participant')
      event = create(:event, organizer: organizer)
      create(:user_event, event: event, participant: first_participant) 
      create(:user_event, event: event, participant: second_participant) 

      events = Event.find_events_by_attendee_name('dave') 

      expect(events).to eq([]) 
    end

  end 

end
