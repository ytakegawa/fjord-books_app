# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @carol = User.create!(email: 'carol@example.com', name: 'carol', password: 'password')
    @dave = User.create!(email: 'dave@example.com', name: 'dave', password: 'password')
    @carol_followed_dave = @carol.follow(@dave)
  end

  test 'name or email' do
    user = User.new(email: 'foo@example.com', name: '')

    assert_equal 'foo@example.com', user.name_or_email

    user.name = 'hoge'
    assert_equal 'hoge', user.name_or_email
  end

  test 'follow' do
    assert_equal @carol.id, @carol_followed_dave.follower_id
    assert_equal @dave.id, @carol_followed_dave.following_id
  end

  test 'following?' do
    assert_not @dave.following?(@carol)
    assert @carol.following?(@dave)
  end

  test 'followed_by?' do
    assert_not @carol.followed_by?(@dave)
    assert @dave.followed_by?(@carol)
  end

  test 'unfollow' do
    assert_not @dave.unfollow(@carol)
    assert @carol.unfollow(@dave)
  end
end
