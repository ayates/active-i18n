require 'active_record'

module ActiveI18n

  autoload :ActiveRecord, 'active_i18n/active_record'

end # ActiveI18n

ActiveRecord::Base.extend(ActiveI18n::ActiveRecord::ActMacro)