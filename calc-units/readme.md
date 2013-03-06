# Convert px to em

## The Functions:

	// Strip Units
	// http://stackoverflow.com/questions/12328259/how-do-you-strip-the-unit-from-any-number-in-sass
	@function clean( $val ) {
		@return $val / ($val * 0 + 1);
	}

	// Calculate ratio of two values
	@function ratio( $val, $context, $unit: 1 ) {
		// If units are the same, they will cancel out when dividing
		@if unit( $val ) == unit( $context ) {
			@return ($val / $context) * $unit;
		}
		// If mixed units, clean them before dividing
		@else {
			@return ( clean($val) / clean($context) ) * $unit;
		}
	}

	// Convert any number of fixed values to relative
	@function unit-convert( $vals, $context, $units: 1em ) {
	
		// Create empty list to append converted values to
		$output: ();
	
		// Loop through each value, convert, and append to $output list
		@for $i from 1 through length( $vals ) {
			$val: nth( $vals, $i );
			// Only convert values in px
			@if unit( $val ) == 'px' or unit( $val ) == '' {
				// Convert to specified units
				$output: append( $output, ratio( $val, $context, $units ), space );
			}
			// Otherwise, return the same value
			@else {
				$output: append( $output, $val, space );
			}
		}
	
		// Return converted values
		@return $output;
	}

	// Calculate percentages
	@function percent( $val, $context: 16 ) {
		@return unit-convert( $val, $context, 100% );
	}

	// Calculate rems
	@function rem( $val, $context: 16 ) {
		@return unit-convert( $val, $context, 1rem );
	}

	// Calculate ems
	@function em( $val, $context: 16 ) {
		@return unit-convert( $val, $context, 1em );
	}

	// Set value as percentage
	@function percentage( $val ) {
		// Return value if already a pecentage
		@if unit( $val ) == '%' {
			@return $val;
		}
		// Otherwise, strip units and convert to percentage
		@return clean( $val ) * 100%;
	}

	// Set value as px
	@function px( $val ) {
		// Return value if already in pixels
		@if unit( $val ) == 'px' {
			@return $val;
		}
		// Otherwise, strip units and convert to px
		@return clean( $val ) * 1px;
	}


## Usage

###Sass:

	div {
		padding: percent( 10px 5px, 250px );
		padding: percent( 20px 2.5% 1em, 225px ); // Will not convert relative units
	}

###CSS:

	div {
		padding: 4% 2%;
		padding: 8.88889% 2.5% 1em; // Only px values were converted
	}

**Attribution**: [The Sass Way](http://thesassway.com/intermediate/responsive-web-design-part-1)