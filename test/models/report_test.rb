# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable' do
    alice = User.create!(email: 'ali@example.com', name: 'alice', password: 'password')
    bob = User.create!(email: 'bob@example.com', name: 'bob', password: 'password')
    alice_report = Report.create!(user_id: alice.id, title: 'テスト日報', content: '日報を作成しました')
    bob_report = Report.create!(user_id: bob.id, title: 'テスト日報', content: '日報を作成しました')

    assert_not alice_report.editable?(bob)
    assert alice_report.editable?(alice)
  end

  test 'created_on' do
    carol = User.create!(email: 'carol@example.com', name: 'carol', password: 'password')
    carol_report = Report.create!(user_id: carol.id, title: 'テスト日報', content: '日報を作成しました')

    assert Date.today == carol_report.created_on
  end
end
