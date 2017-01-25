class Tag < ApplicationRecord
  validates :tag,
            :tagContent, presence: true
  belongs_to :url
end
