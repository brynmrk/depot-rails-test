class Category < ActiveRecord::Base
  has_many :products

  private

  validates :name, :description, presence: true
  validates :name, uniqueness: true
end
