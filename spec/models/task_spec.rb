require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do
    it "should change a false complete to true" do
      task = Task.create(complete: false)

      task.toggle_complete!
      expect(task.complete).to eq(true)
      expect(task.complete).to_not eq(false)
    end
  end
end
