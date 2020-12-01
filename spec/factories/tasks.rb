FactoryBot.define do
  factory :task do
    name { 'task_name1' }
    detail { 'task_detail1' }
    status { '未着手' }
    association :user

    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :second_task, class: Task do
    name { 'sample_name2' }
    detail { 'task_detail2' }
    status { '完了' }
    association :user
  end
end
