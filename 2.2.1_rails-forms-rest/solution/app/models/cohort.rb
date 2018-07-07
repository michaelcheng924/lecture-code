class Cohort < ApplicationRecord
  # has_many :students
  validates :name, presence: true, length: { minimum: 5 }, uniqueness: true
end
