 module Enumerative

   module Enumeration

     def self.included( other_module )
       other_module.module_eval do
         valid_keys.each do |k|
           const_set k.gsub( /\s/, '_' ).upcase, other_module.new( k )
         end

         extend ClassMethods

         attr_reader :key
       end
     end

     module ClassMethods

       def to_select
         valid_keys.sort.collect do |k|
           [translate( k ), k]
         end
       end

       def translate( key )
         I18n.translate "enumerations.#{name.underscore}.#{key}", :raise => true
       rescue I18n::MissingTranslationData
         nil
       end

     end

     def initialize( key_hash_or_enum )
       key = nil
       if key_hash_or_enum.is_a?( Hash )
         key = key_hash_or_enum['key'] || key_hash_or_enum[:key]
       elsif key_hash_or_enum.is_a?( Enumerative::Enumeration )
         key = key_hash_or_enum.key
       else
         key = key_hash_or_enum
       end

       @key = (key.nil? || key.empty?) ?
                nil :
                key.to_s.try( :dup ).try( :freeze )
     end

     def ==( other )
       other.is_a?( self.class ) && (other.key == key)
     end

     def to_s
       key
     end

     def valid?
       key.blank? || self.class.valid_keys.include?( key )
     end

     def value
       key.blank? ? nil : self.class.translate( key )
     end

     def blank?
       key.blank?
     end

     # Method is required for Rails > 3.2.x due to ActiveRecord's autosave
     # functionality.
     #
     def marked_for_destruction?
       false
     end

   end

 end
