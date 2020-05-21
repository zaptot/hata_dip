class BaseForm
  include ActiveModel::Model

  attr_accessor :success

  def save
    ActiveRecord::Base.transaction do
      begin
        if valid?
          persist!
          @success = true
        else
          @success = false
        end
      rescue => e
        self.errors.add(:base, e.message)
        @success = false
      end
    end
  end

  protected

  def persist!
    Raise 'persist not implemented'
  end
end