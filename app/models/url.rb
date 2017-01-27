class Url < ApplicationRecord
  include Parser

  has_many :tags
  attr_accessor :data

  validates :url, presence: true, uniqueness: true
  after_save :get_tags

  def get_tags
    parse(self.data)
  end

  def as_json(options={})
    super(only: [:url], include: {tags: {only: [:tag,:tagContent]}})
  end
end
