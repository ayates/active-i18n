module ActiveI18n
  module ActiveRecord
    class Translation < ::ActiveRecord::Base

      abstract_class = true

      belongs_to :translatable, polymorphic: true

      validates :locale, presence: true

      delegate :to_s, to: :value

    end # Translation
  end # ActiveRecord
end # ActiveI18n