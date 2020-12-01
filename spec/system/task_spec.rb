require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
describe '新規作成機能' do
  before do
    user = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user2)
    FactoryBot.create(:task, user: user)
    FactoryBot.create(:second_task, user: user2 )
    visit new_session_path
    fill_in 'session_email', with:'sample1@aol.com'
    fill_in 'session_password', with:'password'
    click_on 'Log in'
  end
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
  before do
    user = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user2)
    FactoryBot.create(:task, user: user)
    FactoryBot.create(:second_task, user: user2 )
    Task.create(id:3, name:'sample_name2', detail:'一番上', status:'完了', user_id:1)
    visit new_session_path
    fill_in 'session_email', with:'sample1@aol.com'
    fill_in 'session_password', with:'password'
    click_on 'Log in'
  end
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
  before do
    user = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user2)
    FactoryBot.create(:task, user: user)
    FactoryBot.create(:second_task, user: user2 )
    visit new_session_path
    fill_in 'session_email', with:'sample1@aol.com'
    fill_in 'session_password', with:'password'
    click_on 'Log in'
  end
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
  before do
    user = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user2)
    FactoryBot.create(:task, user: user)
    FactoryBot.create(:second_task, user: user2 )
    Task.create(id:3, name:'sample_name2', detail:'一番上', status:'完了', user_id:1)
    visit new_session_path
    fill_in 'session_email', with:'sample1@aol.com'
    fill_in 'session_password', with:'password'
    click_on 'Log in'
    visit tasks_path
  end
  context 'タイトルであいまい検索をした場合' do
    it "検索キーワードを含むタスクで絞り込まれる" do
      fill_in 'name', with:'sample'
      click_on '検索する'
      expect(page).to have_content 'sample'
    end
  end
  context 'ステータス検索をした場合' do
    it "ステータスに完全一致するタスクが絞り込まれる" do
      select '未着手', from: 'status'
      click_on '検索する'
      expect(page).to have_selector 'td', text: '未着手'
    end
  end
  context 'タイトルのあいまい検索とステータス検索をした場合' do
    it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
      fill_in 'name', with:'name'
      select '完了', from: 'status'
      click_on '検索する'
      expect(page).to have_content 'name'
      expect(page).to have_selector 'td', text: '完了'
    end
  end
end
end
