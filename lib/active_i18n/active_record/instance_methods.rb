module ActiveI18n
  module ActiveRecord
    module InstanceMethods

      def method_missing(method_name, *args, &block)
        super unless translatable_attribute?(method_name) or translated_attribute?(method_name)

        locale, attribute_name = translation_locale_for(method_name)

        @translation_store ||= {}
        @translation_store[locale] ||= {}

        if method_name.to_s.include?('=')
          @translation_store[locale][attribute_name] = args.first
        else
          @translation_store[locale][attribute_name] ||= self.translations.where(locale: locale, attribute_name: attribute_name).first
        end
      end

      def respond_to_missing?(method_name, include_private = true)
        translatable_attribute?(method_name) or translated_attribute?(method_name)
      end

    private

      def translatable_attribute?(method_name)
        self.translatable_attributes.any? {|attribute| [ attribute.to_sym, :"#{attribute}=" ].include?(method_name) }
      end

      def translated_attribute?(method_name)
        self.translatable_attributes.any? {|attribute| method_name.to_s =~ Regexp.new("^(#{attribute})_([a-z]{2})\=?$") }
      end

      def translatable_attributes_in(new_attributes)
        new_attributes.map {|attribute, value| attribute if translated_attribute?(attribute) }.compact
      end

      def translation_locale_for(method_name)
        if method_name.to_s.match(/(.*)_([a-z]{2})\=?$/)
          [$2,$1]
        else
          [I18n.locale, method_name.to_s.gsub('=','')]
        end
      end

      def save_translations!
        return unless @translation_store.is_a?(Hash)

        @translation_store.each_pair do |locale, translation_set|
          translation_set.each_pair do |attribute, value|
            translation       = self.translations.find_or_create_by_locale_and_attribute_name(locale, attribute)
            translation.value = value
            translation.save
          end
        end
      end

    end # InstanceMethods
  end # ActiveRecord
end # ActiveI18n