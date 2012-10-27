module ActiveI18n
  module ActiveRecord
    module ActMacro

      def translates(*fields)
        class_attribute :translatable_attributes

        attr_accessor :translation_store

        self.translatable_attributes = fields.map(&:to_sym)

        has_many :translations, as:         :translatable,
                                class_name: translation_class.name,
                                dependent:  :destroy

        include InstanceMethods

        before_save :save_translations!
      end

    protected

      def translation_class
        ::ActiveI18n::ActiveRecord::Translation
      end

    end # ActMacro
  end # ActiveAdmin
end # ActiveI18n