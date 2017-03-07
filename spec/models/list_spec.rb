require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it "should mark all of a list's tasks as complete" do
      list = List.create(name: "Jack Spy Me 3")
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!
      # expect(list.tasks.where(complete: true).length).to eq(3)
      list.tasks.map { |task|
        expect(task.complete).to eq(true) }
    end
  end
end
