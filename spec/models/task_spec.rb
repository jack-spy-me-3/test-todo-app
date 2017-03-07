require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do
    it "should change a false complete to true" do
      task = Task.create(complete: false)

      task.toggle_complete!
      expect(task.complete).to eq(true)
      # expect(task.complete).to_not eq(false)
    end
  end

  describe '#toggle_favorite!' do
    it "should change a false favorite to a true favorite" do
      task = Task.new(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe '#overdue?' do
    it "should return false if the deadline has not passed" do
      task = Task.new(deadline: 1.hour.from_now)
      expect(task.overdue?).to eq(false)
    end

    it "should return true if the deadline has passed" do
      task = Task.new(deadline: 1.hour.ago)
      expect(task.overdue?).to eq(true)
    end
  end

  describe '#increment_priority!' do
    it "should increase the priority number by 1" do
      task = Task.new(priority: 5)
      task.increment_priority!
      expect(task.priority).to eq(6)
      expect(task.priority).to_not eq(5)
    end

    it "should not increase the priority if the number is 10 or greater" do
      task = Task.new(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
      expect(task.priority).to_not eq(11)
    end
  end

  describe '#decrement_priority!' do
    it "should decrease the priority number by 1" do
      task = Task.new(priority: 5)
      task.decrement_priority!
      expect(task.priority).to eq(4)
      expect(task.priority).to_not eq(5)
    end

    it "should not decrease the priority if the number is 1 or less" do
      task = Task.new(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
      expect(task.priority).to_not eq(0)
    end
  end

  describe '#snooze_hour!' do
    it "should increase the deadline by 1 hour" do
      time = Time.now
      task = Task.new(deadline: time)
      task.snooze_hour!
      expect(task.deadline).to eq(time + 1.hour)
    end
  end

end
