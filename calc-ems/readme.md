# Retina Media Query Mixin

## The Mixin:

	@function calc-em($px, $base: 16px) {
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