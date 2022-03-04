require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name or email' do
    user = User.new(email: 'foo@example.com', name: '')

    assert_equal 'foo@example.com', user.name_or_email

    user.name = 'hoge'
    assert_equal 'hoge', user.name_or_email
  end

  test 'follow' do
    alice = User.create!(email: 'ali@example.com', name: 'alice', password: 'password')
    bob = User.create!(email: 'bob@example.com', name: 'bob', password: 'password')

    assert_not alice.following?(bob)
    alice.follow(bob)
    assert alice.following?(bob)
    assert_not alice.followed_by?(bob)
    assert bob.followed_by?(alice)
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
