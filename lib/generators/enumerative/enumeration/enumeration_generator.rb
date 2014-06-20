require 'rails/generators'

module Enumerative

  class EnumerationGenerator < Rails::Generators::Base

    desc "Description:\n  Creates the specified enumeration with values, a spec and an entry in the en.yml file."

    argument :enumeration_name, :type => :string, :required => true
    argument :values, :type => :array

    def self.source_root
      File.join File.dirname(__FILE__),
                'templates'
    end

    def install_enumeration
      template "enumeration.rb", File.join( 'app', path, "#{file_name}.rb" )
    end

    def install_enumeration_spec
      template "enumeration_spec.rb", File.join( 'spec', path, "#{file_name}_spec.rb" )
    end

    def insert_translation
      text = []
      text << "    #{file_name}:"
      text += keys_and_values.sort { |a,b| a.first <=> b.first }.map { |k,v| "      #{k}: #{quote_if_numeric( v )}" }
      inject_into_file 'config/locales/en.yml', after: "enumerations:\n" do
        text.join( "\n" ) + "\n"
      end
    end

  private

    def quote_if_numeric( val )
      return "'#{val}'" if val =~ /^[0-9]+$/
      val
    end

    def path
      @path ||= first_value_is_path? ?
                  values.shift :
                  File.join( 'enumerations' )
    end

    def first_value_is_path?
      !values.first.include?( ":" )
    end

    def keys_and_values
      values.map do |key_and_value|
        key_and_value.split( ":" )
      end.sort { |a,b| a.first <=> b.first }
    end

    def file_name
      enumeration_name.underscore
    end

    def enumeration_class
      enumeration_name.camelcase
    end

  end

end
