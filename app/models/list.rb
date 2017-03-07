class List < ApplicationRecord
  has_many :tasks

  def complete_all_tasks!
    tasks.update_all(complete: true)
  end

  def snooze_all_tasks!
    tasks.each { |task| task.snooze_hour! }
  end

  def total_duration
    tasks.inject(0) { |total, task| total + task.duration }
  end

  def incomplete_tasks
    # array_of_tasks = []
    # tasks.each do |task|
    #   if !task.complete
    #     array_of_tasks << task
    #   end
    # end
    # return array_of_tasks
    incomplete_tasks = tasks.select { |task| task if !task.complete }
    # binding.pry
    incomplete_tasks
  end

  def favorite_tasks
    # array_of_tasks = []
    # tasks.each do |task|
    #   if task.favorite
    #     array_of_tasks << task
    #   end
    # end
    # return array_of_tasks
    tasks.select { |task| task if task.favorite }
  end
end
