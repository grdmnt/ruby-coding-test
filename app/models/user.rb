class User < ApplicationRecord
  has_paper_trail

  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  before_validation do
    self.email = email.downcase
  end

  def is_admin?
    type == 'Admin'
  end

  def email_history
    emails = versions.map do |v|
      next if v.reify.nil?

      { email: v.reify.email, created_at: v.created_at.strftime('%D %r') }
    end

    emails.compact.uniq.reverse
  end
end
