# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:test_book)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本'
  end

  test 'creating a Book' do
    visit books_url
    click_on '新規作成'

    fill_in 'メモ', with: 'すごいよお'
    fill_in 'タイトル', with: '新規作成テストブック'
    fill_in '著者', with: 'foo'
    click_button '登録する'

    assert_text '本が作成されました。'
    assert_text 'すごいよお'
    assert_text '新規作成テストブック'
    assert_text 'foo'
  end

  test 'updating a Book' do
    visit books_url
    click_link '編集'

    fill_in 'メモ', with: 'わかりやすいよお'
    fill_in 'タイトル', with: '更新テスト'
    fill_in '著者', with: 'bar'
    click_button '更新する'

    assert_text '本が更新されました'
    assert_text 'わかりやすいよお'
    assert_text '更新テスト'
    assert_text 'bar'
  end

  test 'destroying a Book' do
    visit books_url
    page.accept_confirm do
      click_on '削除'
    end

    assert_text '本が削除されました。'
  end
end
