require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    click_on 'ユーザ'
    assert_selector 'h1', text: 'ユーザ'
  end

  test 'ceate a user account' do
    click_on 'ログアウト'
    click_on 'アカウント登録'

    fill_in 'Eメール', with: 'bob@example.com'
    fill_in '氏名', with: 'ボブ'
    fill_in '郵便番号', with: '123-4567'
    fill_in '住所', with: 'カルフォルニア'
    fill_in '自己紹介', with: 'カルフォルニア生まれのボブです。'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    attach_file 'ユーザ画像', 'test/fixtures/kitten.jpg'
    click_button 'アカウント登録'

    assert_text 'アカウント登録が完了しました'
    assert_text 'bob@example.com としてログイン中'
  end

  test 'updating a user account' do
    click_on 'アカウント編集'

    fill_in 'Eメール', with: 'carol@example.com'
    fill_in '氏名', with: 'キャロル'
    fill_in '郵便番号', with: '123-7890'
    fill_in '住所', with: 'ニューヨーク'
    fill_in '自己紹介', with: 'ニューヨーク生まれのキャロルです。'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    fill_in '現在のパスワード', with: 'password'
    attach_file 'ユーザ画像', 'test/fixtures/kitten_2.jpg'
    click_button '更新'

    assert_text 'carol@example.com'
    assert_text 'キャロル'
    assert_text '123-7890'
    assert_text 'ニューヨーク'
    assert_text 'ニューヨーク生まれのキャロルです。'
    assert_text 'アカウント情報を変更しました'
  end

  test 'destroying a user account' do
    click_on 'アカウント編集'
    page.accept_confirm do
      click_button 'アカウント削除'
    end

    assert_text 'アカウントを削除しました。'
  end
end
