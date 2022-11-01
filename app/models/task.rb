# frozen_string_literal: true

class Task < ActiveRecord::Base
  MAX_TITLE_LENGTH = 125
  validates :title, presence: true, length: { maximum: MAX_TITLE_LENGTH }
end
