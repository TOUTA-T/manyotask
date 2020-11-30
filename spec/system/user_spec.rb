require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
  describe 'ユーザー登録のテスト' do
    it 'ユーザの新規登録ができる' do
      # adminユーザーを登録しないとバリデーションに引っかかるので作成
      user = FactoryBot.create(:user)
      FactoryBot.create(:task, user: user)
      visit new_user_path
      fill_in 'user_name', with:'name'
      fill_in 'user_email', with:'name@aol.com'
      fill_in 'user_password', with:'password'
      fill_in 'user_password_confirmation', with:'password'
      click_on 'アカウント作成'
      expect(page).to have_content 'ログインしました'
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした時' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン画面'
      end
    end
  end

  describe 'セッション機能のテスト' do
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
    it 'ログインができる' do
      expect(page).to have_content 'プロフィール編集'
    end
    it '自分の詳細画面に飛べる'do
      visit user_path(1)
      expect(page).to have_content 'のページ'
    end
    context '一般ユーザが他人の詳細画面に飛ぶと' do
      it 'タスク一覧画面に遷移する' do
        visit user_path(2)
        expect(page).to have_content '他の人の'
      end
    end
    it 'ログアウトができる'do
      click_on 'Logout'
      expect(page).to have_content 'ログアウトしました'
    end
  end
  describe '管理画面のテスト' do
    before do
      user = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user2)
      FactoryBot.create(:task, user: user)
      FactoryBot.create(:second_task, user: user2 )
    end
    context '一般ユーザは' do
      it '管理画面にアクセスできない' do
        visit new_session_path
        fill_in 'session_email', with:'sample2@aol.com'
        fill_in 'session_password', with:'password'
        click_on 'Log in'
        click_on '管理ページへ'
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end
    context '管理ユーザは' do
      before do
        visit new_session_path
        fill_in 'session_email', with:'sample1@aol.com'
        fill_in 'session_password', with:'password'
        click_on 'Log in'
        click_on '管理ページへ'
      end
      it '管理画面にアクセスできる' do
        expect(page).to have_content '管理画面のユーザー一覧'
      end
      it 'ユーザの新規登録ができること' do
        click_on '新規ユーザー登録', match: :first
        fill_in 'user_name', with:'name'
        fill_in 'user_email', with:'name@aol.com'
        fill_in 'user_password', with:'password'
        fill_in 'user_password_confirmation', with:'password'
        click_on 'アカウント作成'
        expect(page).to have_content 'ログインしました'
      end
      it 'ユーザの詳細画面にアクセスできる' do
        click_on '詳細', match: :first
        expect(page).to have_content 'sample1'
      end
      it 'ユーザの編集画面からユーザを編集できる' do
        click_on '編集', match: :first
        fill_in 'user_name', with:'name'
        fill_in 'user_email', with:'name@aol.com'
        click_on '更新'
        expect(page).to have_content '会員権限で更新'

      end
      it 'ユーザの削除ができる' do
      end
    end
  end
end
