class Event < ApplicationRecord
  validates :start_date, presence: true
  validate :start_date_in_future

  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :duration_is_multiple_of_5

  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  validates :location, presence: true

  belongs_to :admin, class_name: 'User'
  has_many :attendances
  has_many :users, through: :attendances
  private 

  def start_date_in_future
    if start_date.present? && start_date <= DateTime.now
      errors.add(:start_date, "doit être dans le futur")
    end
  end


  def duration_is_multiple_of_5
    if duration.present? && duration % 5 != 0
      errors.add(:duration, "doit être un multiple de 5 et différent de 0")
    end
  end

end
