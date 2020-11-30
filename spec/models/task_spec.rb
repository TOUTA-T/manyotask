require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  before do
    user = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user2)
    FactoryBot.create(:task, user: user)
    FactoryBot.create(:second_task, user: user2 )
  end
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '', detail: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗タイトル', detail: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '成功タイトル', detail: '成功テスト', user_id: 1 )
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task1){ Task.first }
    let!(:task2){ Task.last }
  context 'scopeメソッドでタイトルのあいまい検索をした場合' do
    it "検索キーワードを含むタスクが絞り込まれる" do
      expect(Task.name_like('task')).to include(task1)
      expect(Task.name_like('task')).not_to include(task2)
      expect(Task.name_like('task').count).to eq 1
    end
  end
  context 'scopeメソッドでステータス検索をした場合' do
    it "ステータスに完全一致するタスクが絞り込まれる" do
      expect(Task.status('未着手')).to include(task1)
      expect(Task.status('未着手')).not_to include(task2)
      expect(Task.status('未着手').count).to eq 1
    end
  end
  context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
    it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
      expect(Task.double('task','未着手')).to include(task1)
      expect(Task.double('task','完了')).not_to include(task2)
      expect(Task.double('task','未着手').count).to eq 1
    end
  end
end
end
