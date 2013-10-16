 module Enumerative

   module HasEnumeration

     def self.included( other_module )
       other_module.extend ClassMethods
     end

     module ClassMethods

       def has_enumeration( *attributes )
         options = attributes.extract_options!
         class_name = if options[:from].try( :is_a?, Class )
                        options[:from].name
                      else
                        options[:from]
                      end
         if class_name && !class_name.constantize.include?( Enumeration )
           raise ArgumentError,
                 ':from option should refer to a class that mixes in Enumeration'
         end

         attributes.each do |a|
           define_method a do
             return instance_variable_get( "@#{a}" ) unless instance_variable_get( "@#{a}" ).nil?
             instance_variable_set( "@#{a}", class_name.constantize.new( a ))
           end
           #composed_of a, :allow_nil => true,
                          #:class_name => class_name || a.to_s.classify,
                          #:mapping => [a, 'key'],
                          #:converter => :new

           validates_associated a, :allow_blank => true
         end
       end

     end

   end

 end
