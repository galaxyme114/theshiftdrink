module ActiveRecordExtension

  extend ActiveSupport::Concern

  def first_error_message
    errors.full_messages.first
  end

  module ClassMethods
    # => E.g: User.find_by_multiple!([:username, :email], "samso") 
    def find_by_multiple!(fields, input)
      fields.delete(:id) if !input.is_integer? && fields.include?(:id)
      sql = fields.map(&->(f){ f.to_s.concat('= :i') }).join(' OR ')
      where(sql, { i: input.to_s }).take!
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtension)