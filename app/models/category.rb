class Category < ApplicationRecord

  validates_presence_of :title

  scope :search_title, -> (title) { where("title LIKE ?", "%#{title}") if title.present? }
end
