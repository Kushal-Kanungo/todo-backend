class Todo < ApplicationRecord
  validates :title, presence: true
  validates :priority, presence: true, inclusion: { in: %w[High Medium Low],
                                                    message: '%<value>s is not a valid priority' }
  validates :description, presence: true, length: { minimum: 2 }
  validates :status, presence: true, inclusion: { in: %w[NEW INPROGRESS DONE],
                                                  message: '%<value>s is not a valid status' }
end

