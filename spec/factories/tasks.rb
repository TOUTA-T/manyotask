FactoryBot.define do
  factory :task do
    name { 'task_name1' }
    detail { 'task_detail1' }
  end
  factory :second_task, class: Task do
    name { 'task_name2' }
    detail { 'task_detail2' }
  end
end
