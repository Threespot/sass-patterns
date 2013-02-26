# Convert px to em

## The Functions:

	@function makePixel( $val ) {
		@if unitless( $val ) {
			$val: $val * 1px;
		}
		@return $val;
	}

	@function calc-em( $px, $base: 16px ) {
		@return ( makePixel($px) / makePixel($base) ) * 1em;
	}

## Usage

###Sass:

	.featured {
		padding: calc-em( 10px );
	}

###CSS:

	.featured {
		padding: 0.625em;
	}

**Attribution**: [The Sass Way](http://thesassway.com/intermediate/responsive-web-design-part-1)