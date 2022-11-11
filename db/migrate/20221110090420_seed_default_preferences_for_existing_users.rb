# frozen_string_literal: true

class SeedDefaultPreferencesForExistingUsers < ActiveRecord::Migration[7.0]
  def up
    users_without_preferences = User.where.missing(:preference)
    users_without_preferences.each do |user|
          user.send(:build_default_preference)
          user.save!
        end
  end

  def down
    User.find_each do |user|
      user.preference.delete
    end
  end
end
