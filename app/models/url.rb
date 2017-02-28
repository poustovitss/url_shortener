class Url < ApplicationRecord
  validates :original_url, presence: true, format: {
      with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i }
end
