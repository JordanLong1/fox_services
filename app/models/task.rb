class Task < ApplicationRecord
  belongs_to :list
  belongs_to :employee, optional: true

  before_validation :normalize_title, :normalize_content, :normalize_address, on: [:create, :update]
  
  validates :title, :address, :content, presence: true

  scope :most_recent, -> {Task.order("created_at DESC").limit(5)}
  scope :tasks_by_employee,  ->(name) {Task.where("employee_id == ?", name)}
  scope :incomplete_tasks, -> {Task.where("completed == ?", false)}

  private 

  def normalize_title 
    self.title = title.titlecase 
  end

  def normalize_content 
    self.content = content.capitalize 
  end

  def normalize_address 
    self.address = address.titlecase 
  end

end
