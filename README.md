# Enumerative

Provides enumeration functionality.

## Installation

Add this line to your application's Gemfile:

    gem 'enumerative'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enumerative

## Usage

Create an enumeration class and include the modiule.

    class Color
    
      def self.valid_keys
        %w(
          black
          blue
          green
        )
      end
    
      include Enumerative::Enumeration # this must come after ::valid_keys
    
    end

Declare the enumeration in an ActiveModel.

    class Vehicle

      include Enumerative::HasEnumeration

      # add_column :vehicles, :color, :string, :limit => 35

      has_enumeration :color, :from => Color

    end

Translate the enumeration using localization:

    en:
      enumerations:
        color:
          black: Black
          blue: Blue
          green: Green

Use the enumeration:

    vehicle = Vehicle.create( :color => 'black' )

    vehicle.attributes['color'] # => black
    vehicle.color               # => #<Color:0x10702d5e8 @key="black">
    vehicle.color.key           # => black
    vehicle.color.value         # => Black
    vehicle.color.to_s          # => black
