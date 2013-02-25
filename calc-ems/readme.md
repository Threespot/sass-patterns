# Retina Media Query Mixin

## The Mixin:

	@function calc-em( $px, $base: 16px ) {
	
		@if unitless( $px ) {
			$px: $px * 1px;
		}
	
		@if unitless( $base ) {
			$base: $base * 1px;
		}

		@return ($px / $base) * 1em;
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