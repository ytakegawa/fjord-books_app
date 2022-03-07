require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit root_url
    click_on '日報'
    assert_selector 'h1', text: '日報'
  end

  test 'ceate a report' do
    visit root_url
    click_on '日報'
    click_on '新規作成'

    fill_in 'タイトル', with: '日報作成テスト'
    fill_in '内容', with: '面白い日報です'
    click_button '登録する'

    assert_text '日報が作成されました'
    assert_text '日報作成テスト'
    assert_text '面白い日報です'
  end

  test 'updating a report' do
    visit root_url
    click_on '日報'
    click_on '編集'

    fill_in 'タイトル', with: '更新テスト'
    fill_in '内容', with: '更新しました'
    click_button '更新する'

    assert_text '日報が更新されました'
    assert_text '更新テスト'
    assert_text '更新しました'
  end

  test 'destroying a report' do
    visit root_url
    click_on '日報'
    page.accept_confirm do
      click_on '削除'
    end

    assert_text '日報が削除されました。'
  end
end
