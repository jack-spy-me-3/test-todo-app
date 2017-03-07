require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it "should mark all of a list's tasks as complete" do
      list = List.create
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!
      # expect(list.tasks.where(complete: true).length).to eq(3)
      list.tasks.each { |task|
        expect(task.complete).to eq(true) }
    end
  end

  describe '#snooze_all_tasks!' do
    it "should change the deadline of all list tasks by an hour" do
      list = List.create
      time = Time.now
      Task.create(deadline: time, list_id: list.id)
      Task.create(deadline: time, list_id: list.id)
      Task.create(deadline: time, list_id: list.id)
      list.snooze_all_tasks!
      list.tasks.each do |task|
        expect(task.deadline).to eq(time + 1.hour)
      end
    end
  end

  describe '#total_duration' do
    it "should add up all the duration times" do
      list = List.create
      Task.create(duration: 25, list_id: list.id)
      Task.create(duration: 50, list_id: list.id)
      Task.create(duration: 100, list_id: list.id)
      expect(list.total_duration).to eq(175)
    end
  end

  describe '#incomplete_tasks' do
    it "should return an array of incomplete tasks" do
      list = List.create
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: true, list_id: list.id)
      task1 = Task.create(complete: false, list_id: list.id)
      task2 = Task.create(complete: false, list_id: list.id)
      incomplete_tasks = list.incomplete_tasks
      expect(incomplete_tasks.length).to eq(2)
      # incomplete_tasks.each do |task|
      #   expect(task.complete).to eq(false)
      # end
      expect(incomplete_tasks).to eq([task1, task2])
    end
  end

  describe '#favorite_tasks' do
    it "should return an array of my favorite tasks" do
      list = List.create
      task1 = Task.create(favorite: true, list_id: list.id)
      task2 = Task.create(favorite: true, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      favorite_tasks = list.favorite_tasks
      expect(favorite_tasks.length).to eq(2)
      expect(favorite_tasks).to eq([task1, task2])
    end
  end
end
