require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'events should not be able to be saved without setting the event_name, created_by, and scheduled_for' do
    event = Event.new start_time: DateTime.now,
                      end_time: DateTime.now, completed: true
    assert_not event.save
  end
end
