class Contact < ActiveRecord::Base
  belongs_to :user
  validates :name, :phone, presence: true
  validates :name, :phone, uniqueness: true
end
