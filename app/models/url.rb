class Url < ApplicationRecord
  validates :original_url, presence: true, format: {
      with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i }
  after_create :set_unique_hash

  def set_unique_hash
    self.unique_hash = "test#{self.id}"
    self.save!
  end
end
