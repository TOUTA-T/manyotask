require 'rails_helper'
DatabaseCleaner.clean
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
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
        task = Task.new(name: '成功タイトル', detail: '成功テスト')
        expect(task).to be_valid
      end
    end
  end
  before do
    @task = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:second_task)
  end
  describe '検索機能' do
  context 'scopeメソッドでタイトルのあいまい検索をした場合' do
    it "検索キーワードを含むタスクが絞り込まれる" do
      # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
      @tasks = Task.all
      binding.irb
      expect(@tasks.name_like('task_name1')).to include(@task.name)
      expect(Task.name_like('task')).not_to include('second_task')
      expect(Task.name_like('task').count).to eq 1
    end
  end
  context 'scopeメソッドでステータス検索をした場合' do
    it "ステータスに完全一致するタスクが絞り込まれる" do
      # ここに内容を記載する
    end
  end
  context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
    it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
      # ここに内容を記載する
    end
  end
end
end
