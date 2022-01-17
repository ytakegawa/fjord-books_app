# frozen_string_literal: true

require 'test_helper'

class FollowTest < ActiveSupport::TestCase
  def setup
    @follow = Follow.new(follower_id: 2, followed_id: 3)
  end

  test 'shold be valid' do
    assert @follow.valid?
  end

  test 'shold require a follower_id' do
    @follow.follower_id = nil
    assert_not @follow.valid?
  end

  test 'shold require a followed_id' do
    @follow.followed_id = nil
    assert_not @follow.valid?
  end
end
