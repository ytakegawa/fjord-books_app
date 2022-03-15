# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable' do
    carol = User.create!(email: 'carol@example.com', name: 'carol', password: 'password')
    dave = User.create!(email: 'dave@example.com', name: 'dave', password: 'password')
    carol_report = Report.create!(user_id: carol.id, title: 'テスト日報', content: '日報を作成しました')

    assert_not carol_report.editable?(dave)
    assert carol_report.editable?(carol)
  end

  test 'created_on' do
    carol = User.create!(email: 'carol@example.com', name: 'carol', password: 'password')
    carol_report = Report.create!(user_id: carol.id, title: 'テスト日報', content: '日報を作成しました')
    travel_to Time.zone.local(2022, 3, 15) do
      assert_equal Time.zone.today, carol_report.created_on
    end
  end
end
