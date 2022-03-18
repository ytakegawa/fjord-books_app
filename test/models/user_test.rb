# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
  end

  test 'name or email' do
    user = User.new(email: 'foo@example.com', name: '')

    assert_equal 'foo@example.com', user.name_or_email

    user.name = 'hoge'
    assert_equal 'hoge', user.name_or_email
  end

  test 'follow' do
    carol = User.create!(email: 'carol@example.com', name: 'carol', password: 'password')
    dave = User.create!(email: 'dave@example.com', name: 'dave', password: 'password')
    follow = carol.follow(dave)

    assert_equal carol.id, follow.follower_id
    assert_equal dave.id, follow.following_id
  end

  test 'following?' do
    assert_not @bob.following?(@alice)
    assert @alice.following?(@bob)
  end

  test 'followed_by?' do
    assert_not @alice.followed_by?(@bob)
    assert @bob.followed_by?(@alice)
  end

  test 'unfollow' do
    assert_not @bob.unfollow(@alice)
    assert @alice.unfollow(@bob)
  end
end
