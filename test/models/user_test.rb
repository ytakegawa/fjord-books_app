require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name or email' do
    user = User.new(email: 'foo@example.com', name: '')

    assert_equal 'foo@example.com', user.name_or_email

    user.name = 'hoge'
    assert_equal 'hoge', user.name_or_email
  end

  test 'follow' do
    # alice = User.find_by(:alice)
    # bob = User.find_by(:bob)
    carol = User.create!(email: 'carol@example.com', name: 'carol', password: 'password')
    dave = User.create!(email: 'dave@example.com', name: 'dave', password: 'password')

    assert_not carol.following?(dave)
    carol.follow(dave)
    assert carol.following?(dave)
    assert_not carol.followed_by?(dave)
    assert dave.followed_by?(carol)
  end

  test 'unfollow' do
    carol = User.create!(email: 'carol@example.com', name: 'carol', password: 'password')
    dave = User.create!(email: 'dave@example.com', name: 'dave', password: 'password')

    assert_not carol.unfollow(dave)
    carol.follow(dave)
    assert carol.unfollow(dave)
    assert_not carol.following?(dave)
  end
end
