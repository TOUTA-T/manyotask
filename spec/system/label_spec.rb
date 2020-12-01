require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  describe '新規作成' do
    before do
      user = FactoryBot.create(:user)
      FactoryBot.create(:task, user: user)
      visit new_session_path
      fill_in 'session_email', with:'sample1@aol.com'
      fill_in 'session_password', with:'password'
      click_on 'Log in'
    end
    context 'ラベルをタスク作成の中で作る場合' do
      it 'ラベルを作成出来る' do
        visit new_task_path
        fill_in 'task_name', with:'テストタイトル'
        fill_in 'task_detail', with:'テスト詳細'
        check 'task_label_ids_1'
        click_on '投稿'
        expect(page).to have_content 'DIVE'
      end
      it '複数のラベルを作成出来る' do
        FactoryBot.create(:second_label)
        visit new_task_path
        fill_in 'task_name', with:'テストタイトル'
        fill_in 'task_detail', with:'テスト詳細'
        check 'task_label_ids_1'
        check 'task_label_ids_2'
        click_on '投稿'
        expect(page).to have_content 'DIVE'
        expect(page).to have_content 'INTO'
      end
      it '詳細画面で、タスクのラベル一覧を表示する' do
        visit tasks_path
        click_on '詳細確認', match: :first
        expect(page).to have_content 'DIVE'
      end
      it 'つけたラベルで検索が出来る' do
        visit tasks_path
        select 'DIVE', from: 'label_id'
        click_on '検索する'
        expect(page).to have_content 'task_name1'
      end
    end
  end
end
