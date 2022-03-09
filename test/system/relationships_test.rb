require 'application_system_test_case'

class RelationshipsTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting followings' do
    click_on 'ユーザ'
    click_on '詳細', match: :first
    click_link 'フォロー'

    assert_selector 'h1', text: 'フォロー'
  end

  test 'visiting followers' do
    click_on 'ユーザ'
    click_on '詳細', match: :first
    click_link 'フォロワー'

    assert_selector 'h1', text: 'フォロワー'
  end

  test 'ceate a follow' do
    click_on 'ユーザ'
    click_on '詳細', match: :first
    click_button 'フォローする'

    assert_text 'フォローしました'
    assert_text '1 フォロワー'

    click_link 'フォロワー'

    assert_text 'alice'
    assert_text 'alice@example.com'
  end

  test 'destroying a follow' do
    click_on 'ユーザ'
    click_on '詳細', match: :first
    click_button 'フォローする'

    assert_text '1 フォロワー'

    click_button 'フォロー解除する'

    assert_text '0 フォロワー'
  end
end
