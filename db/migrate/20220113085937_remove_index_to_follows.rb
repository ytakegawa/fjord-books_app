# frozen_string_literal: true

class RemoveIndexToFollows < ActiveRecord::Migration[6.1]
  def change
    remove_index :follows, :followed_id
  end
end
