class Url < ApplicationRecord
  include Parser

  has_many :tags

  validates :url, presence: true, uniqueness: true
  after_save :get_tags
  attr_accessor :data

  def get_tags
    parse(self.data)
  end

  def as_json(options={})
    super(only: [:url], include: {tags: {only: [:tag,:tagContent]}})
  end
end
