class Company < ApplicationRecord
  has_many :addresses, foreign_key: "company_id", class_name: 'Address'
  belongs_to :naic

  scope :by_name, ->(name) {
    where('name LIKE ?', "%#{name}%")
  }

  scope :by_code, ->(code) {
    joins(:naic).where('naics.code LIKE ?', "%#{code}%")
  }
end

# { joins(:tags).where('tags.id': ids) }
