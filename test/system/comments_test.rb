require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'ceate a comment for a book' do
    click_on '詳細', match: :first

    fill_in 'comment[content]', with: 'Bookテストコメントを入力'
    click_button 'コメントする'

    assert_text 'Bookテストコメントを入力'
    assert_text 'コメントが投稿されました'
  end

  test 'ceate a comment for a report' do
    click_on '日報'
    click_on '詳細', match: :first

    fill_in 'comment[content]', with: 'Reportテストコメントを入力'
    click_button 'コメントする'

    assert_text 'Reportテストコメントを入力'
    assert_text 'コメントが投稿されました'
  end
end
