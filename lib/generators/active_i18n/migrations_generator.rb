module ActiveI18n
  module Generators
    class MigrationsGenerator < ::Rails::Generators::Base

      include Rails::Generators::Migration

      source_root File.expand_path('../../templates', __FILE__)
      desc 'Create the teanslations table migration'

      def copy_migrations
        migration_template 'create_translations.rb', 'db/migrate/create_translations.rb'
      end

      class << self

        def next_migration_number(path)
          unless @prev_migration_nr
            @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
          else
            @prev_migration_nr += 1
          end
          @prev_migration_nr.to_s
        end

      end # self

    end # MigrationsGenerator
  end # Generators
end # ActiveI18n