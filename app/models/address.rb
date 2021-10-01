class Address < ApplicationRecord
  belongs_to :company
  enum address_type: {
      primary: 0,
      secondary: 1
  }
end
