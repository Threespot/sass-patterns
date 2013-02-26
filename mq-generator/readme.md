# Media Query Labels

Easily generate min-width and max-width media queries based on breakpoint labels

## The Mixin:

	/* Generate Media Queries */
	// Reference:
	// http://jakearchibald.github.com/sass-ie/

	// Default breakpoints if not defined
	$breakpoints: small,
	              medium 768,
	              large 960 !default;

	// Get number of breakpoints
	$break-count: length($breakpoints);

	// Set to a px value to trigged fixed layout
	$fix-mqs: false !default;

	// Min-width breakpoint mixin
	@mixin breakpoint( $name ) {
		$width: 0;
		$index: 1; // Create index var to use in @each loop

		// Find width cutoff of breakpoint
		@each $break in $breakpoints {
			@if $name == nth($break, 1) {
			
				// Output plain CSS if fixed width is >= $width
				@if $fix-mqs {
					@if $index == 1 or $fix-mqs >= nth($break, 2) {
						@content;
					}
				}
				// Wrap code in media query
				@else if $index > 1 {
					@media only screen and ( min-width: calc-em( nth($break, 2) ) ) {
						@content;
					}
				}
				// Output plain CSS for smallest breakpoint
				@else {
					@content;
				}
			}
		
			// Increment counter
			$index: $index + 1;
		}
	}

	// Max-width breakpoint mixin
	@mixin max-breakpoint( $name ) {
		$width: 0;
		$index: 1; // Create index var to use in @each loop

		// Find width cutoff of breakpoint
		@each $break in $breakpoints {
			@if $name == nth($break, 1) {
			
				// Output plain CSS if fixed width is >= $width
				@if $fix-mqs {
					@if $index == $break-count or $fix-mqs >= $width {
						@content;
					}
				}
				// Wrap code in media query
				@else if $index < $break-count {
					// Get next breakpoint width, subtract 1px
					$max-width: nth( nth($breakpoints, $index + 1), 2 ) - 1;
				
					@media only screen and ( max-width: calc-em( $max-width ) ) {
						@content;
					}
				}
				// Largest breakpoint
				@else {
					@media only screen and ( max-width: calc-em( nth($break, 2) ) ) {
						@content;
					}
				}
			}
		
			// Increment counter
			$index: $index + 1;
		}
	}


## Usage

###Sass:

	/* Min-width Tests */
	h1 {
		color: #555;
	
		/* This is just for testing. You would not normally use a media query for the smallest view. */
		@include breakpoint( small ) {
			color: red;
		}
	
		@include breakpoint( medium ) {
			color: green;
		}
		@include breakpoint( large ) {
			color: blue;
		}
	}

	/* Max-width Tests */
	h1 {
	
		/* This is just for testing. You would not normally use a media query for the largest view. */
		@include max-breakpoint( large ) {
			font-size: 40px;
		}
	
		@include max-breakpoint( medium ) {
			font-size: 30px;
		}
		@include max-breakpoint( small ) {
			font-size: 20px;
		}
	}


###CSS:

	/* Min-width Tests */
	h1 {
	  color: #555;
	  color: red;
	}
	
	@media only screen and (min-width: 48em) {
	  h1 { color: green }
	}
	
	@media only screen and (min-width: 60em) {
	  h1 { color: blue }
	}

	/* Max-width Tests */
	@media only screen and (max-width: 60em) {
	  h1 { font-size: 40px }
	}
	
	@media only screen and (max-width: 59.9375em) {
	  h1 { font-size: 30px }
	}
	
	@media only screen and (max-width: 47.9375em) {
	  h1 { font-size: 20px }
	}

**Attribution**: Inspired by Jake Archibald's [Sass IE](http://jakearchibald.github.com/sass-ie/)