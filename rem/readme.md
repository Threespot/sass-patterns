# Rems Mixin


## The Mixin: 

    // Convert any property's values to REMs
    // Reference https://github.com/bitmanic/rem/blob/master/stylesheets/_rem.scss
    // Requires rem() function from https://github.com/Threespot/sass-patterns/tree/master/calc-units
    @mixin rem( $property, $px-values ) {
        // Print the first line in pixel values
        #{$property}: $px-values;
    
        // If there is only one (numeric) value, return the property/value line for it.
        @if type-of($px-values) == "number" {
            #{$property}: rem( $px-values );
        }
        @else {
            // Create an empty list that we can dump values into
            $rem-values: ();
            @each $value in $px-values {
                // If the value is zero or not a number, return it
                @if $value == 0 or type-of( $value ) != "number" {
                    $rem-values: append($rem-values, $value);
                }
                // Convert numbers to rems
                @else {
                    $rem-values: append($rem-values, rem( $value ));
                }
            }
            // Return the property and its list of converted values
            #{$property}: $rem-values;
        }
    }

## Usage

###Sass:

    .foo {
        @include rem( padding, 10px 0 25px );
    }

    .bar {
         @include rem( border, 3px solid #f00 );
    }

###CSS:

    .foo {
      padding: 10px 0 25px;
      padding: 0.625rem 0 1.5625rem;
    }

    .bar {
      border: 3px solid red;
      border: 0.1875rem solid red;
    }


**Reference**: [https://github.com/bitmanic/rem/blob/master/stylesheets/_rem.scss](https://github.com/bitmanic/rem/blob/master/stylesheets/_rem.scss)