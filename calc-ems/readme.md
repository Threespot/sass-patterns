# Convert px to em

## The Functions:

	/* Convert value to px */
	@function px( $val ) {
		// Return value if already in pixels
		@if unit( $val ) == 'px' {
			@return $val;
		}
		// Otherwise, strip units and convert to px
		// http://stackoverflow.com/questions/12328259/how-do-you-strip-the-unit-from-any-number-in-sass
		@else {
			@return $val / ($val * 0 + 1) * 1px;
		}
	}

	/* Convert px to em */
	@function em( $px, $base: 16px ) {
		@return ( px($px) / px($base) ) * 1em;
	}

## Usage

###Sass:

	.featured {
		padding: em( 10px );
	}

###CSS:

	.featured {
		padding: 0.625em;
	}

**Attribution**: [The Sass Way](http://thesassway.com/intermediate/responsive-web-design-part-1)