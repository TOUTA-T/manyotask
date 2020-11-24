require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with:'テストタイトル'
        fill_in 'task_detail', with:'テスト詳細'
        click_on '投稿'
        expect(page).to have_content '投稿されました！'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
       expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_list')
        expect(task_list[0]).to have_content"sample_name2"
        expect(task_list[1]).to have_content"task_name1"
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         DatabaseCleaner.clean
         task = FactoryBot.create(:task, name: 'task')
         visit tasks_path
         click_on '詳細確認', match: :first
         expect(page).to have_content 'task'
       end
     end
  end
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'タスク名を入力', with:'name1'
        click_on '検索する'
        expect(page).to have_content 'name1'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '未着手', from: 'ステータス'
        click_on '検索する'
        expect(page).to have_selector 'td', text: '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'タスク名を入力', with:'name2'
        select '完了', from: 'ステータス'
        click_on '検索する'
        expect(page).to have_content 'name2'
        expect(page).to have_selector 'td', text: '完了'
      end
    end
  end
end
