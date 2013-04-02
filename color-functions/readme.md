# Color Functions
Convert any color format to RGBA, with fallback for old IE and optional base background color. Intended for use with a separate IE stylesheet:

	<!-- Modern Browser Styles -->
	<!--[if gte IE 9]><!-->
		<link rel="stylesheet" href="css/main.css">
	<!--<![endif]-->
		
	<!-- Old IE Styles for IE 8 and below (auto-generated using Sass) -->
	<!--[if (lt IE 9) & (!IEMobile) ]>
		<link rel="stylesheet" href="css/main-old-ie.css">
	<![endif]-->


## The Mixin:

	// Convert any color format to plain RGB
	@function get-rgb( $color ) {
		@return rgb( red($color), green($color), blue($color) );
	}


	// Mix translucent color with background to make a flat color for IE
	// Reference: https://github.com/rhysburnie/skeleton-compass/blob/master/stylesheets/bones/utilities/_color.scss
	@function color-flatten( $color, $bg-color: white ) {
		// Get opacity of color, convert to percentage
		$weight: percentage( alpha($color) );
		// Mix new flat color
		@return mix( get-rgb($color), $bg-color, $weight );
	}


	// Set old IE flag if not already defined
	$old-ie: false !default;

	// Convert any color format to RGBA, with fallback for old IE and optional background color to mix
	// Usage: color-alpha( #abc, 0.5) ) => rgba(170, 187, 204, 0.5) or #d4dde5 for old IE
	@function color-alpha( $color, $opacity: none, $bg-color: white, $flat: false ) {
	
		// Check the arguments passed
		// If color already has alpha value (e.g. rgba, hlsa)
		@if alpha( $color ) < 1 {
			// Then check if a second argument was passed
			@if $opacity == 'none' {
				// If no second argumentm, set the opacity as the alpha value
				$opacity: alpha( $color );
			}
			// If second argument is a color
			@else if type-of( $opacity ) == 'color' {
				// Set the bg-color
				$bg-color: $opacity;
				// Set the opacity
				$opacity: alpha( $color );
			}
		}
	
		// Output flat color for IE
		@if $flat or $old-ie {
			// Return flattened color
			@return color-flatten( rgba( $color, $opacity ), $bg-color );
		}
		// Otherwise, return RGBA
		@else {
			@return rgba( $color, $opacity );
		}
	}

	// RGBA black shorthand
	@function black( $opacity ) {
		@return color-alpha( black, $opacity );
	}

	// RGBA white shorthand
	@function white( $opacity ) {
		@return color-alpha( white, $opacity );
	}


	// Same as color-alpha() function above, but generates both the fallback and modern CSS for any property
	// Use if not creating a separate old IE stylesheet, otherwise, use color-alpha()
	@mixin color-prop( $prop, $value, $opacity: 'none', $bg-color: white ) {

		// Set color to $value by default
		$color: $value;
	
		// Location in array of color value
		$colorNth: 1;
	
		// Count values passed
		$valCount: length($value);

		// If mulitple values were passed, determine which is the color
		// (used for shorthand CSS, like "1px solid #ccc" for border)
		@if $valCount > 1 {
			$counter: 1;
			// Loop through values
			@each $val in $value {
				// Check if value is a color
				@if type-of($val) == color {
					// Update color value
					$color: $val;
					// Save location of color in array
					$colorNth: $counter;
				}
				// Increment counter
				$counter: $counter + 1;
			}
		}
	
		// Check if color already has an alpha value
		@if alpha( $color ) < 1 {
			// Then check if an opacity value was passed
			@if $opacity == 'none' {
				// If no opacity, use the color's alpha value
				$opacity: alpha( $color );
			}
		}
	
		// Generate new colors values
		$flatColor: color-alpha( $color, $opacity, $bg-color, true ); // e.g. #cccccc
		$alphaColor: color-alpha( $color, $opacity, $bg-color, false ); // e.g. rgba(0, 0, 0, 0.2)
	
		// Define new values
		$flatVal: '';
		$alphaVal: '';
	
		// Rewrite values if multiple were passed
		@if ( $valCount > 1 ) {
			$counter: 1;
			// Loop though original values and replace the color
			@each $val in $value {
				// If current val is the color, replace it
				@if ( $colorNth == $counter ) {
					// Replace with flat color
					$flatVal: $flatVal + ' ' + $flatColor;
					// Replace with alpha color
					$alphaVal: $alphaVal + ' ' + $alphaColor;
				}
				@else {
					$flatVal: $flatVal + ' ' + $val;
					$alphaVal: $alphaVal + ' ' + $val;
				}
		
				// Increment counter
				$counter: $counter + 1;
			}
		}
		@else {
			$flatVal: $flatColor;
			$alphaVal: $alphaColor;
		}
	
		@debug $flatVal;
		@debug $alphaVal;
	
		// Output CSS
		#{$prop}: unquote( $flatVal ); // Fallback HEX
		#{$prop}: unquote( $alphaVal ); // RGBA
	} 



## color-alpha() Usage
<p><code>color-alpha( $color, $opacity: none, $bg-color: white )</code></p>
Pass a color in any format, optional opacity, and an optional background color to use when generating a flat HEX color for IE.


###Sass:

	div {
		background-color: color-alpha( #abc, 0.5 );
	}

	// In IE stylesheet, set $old-ie to true
	$old-ie: true;

###CSS:

	/* Main Stylesheet */
	div {
		background-color: rgba(170, 187, 204, 0.5);
	}

	/* Old IE stylesheet */
	div {
		background-color: #d4dde5;
	}


You can also use plain RGBA syntax:

###Sass:

	div {
		background-color: color-alpha( rgba(255, 255, 0, 0.3) );
	}


###CSS:

	/* Main Stylesheet */
	div {
		background-color: rgba(255, 255, 0, 0.3);
	}

	/* Old IE stylesheet */
	div {
		background-color: #ff7f7f;
	}


You can set a custom background color to use when creating the flat color for IE:

###Sass:

	div {
		background-color: color-alpha( #ff0, 0.3, #000 );
	}

	/* Alternate syntax */
	div {
		background-color: color-alpha( rgba(255, 255, 0, 0.3), #000 );
	}

###CSS:

	/* Main Stylesheet */
	div {
		background-color: rgba(255, 255, 0, 0.3);
	}
	
	/* Old IE stylesheet */
	div {
		background-color: #4c4c00;
	}


##color-prop() Usage
<p><code>color-prop( $prop, $value, $opacity, $bg-color: white )</code></p>
Pass a property, color or string of values containing a color, opacity, and an optional background color to use when generating a flat HEX color for IE.


###Sass:

	h1 {
		// Basic usage
		@include color-prop( background-color, #fdc, 0.3 );
	
		// CSS shorthand values work fine
		@include color-prop( border-bottom, 10px solid #F78125, 0.5 );
	
		// You can use an RGBA value and omit the opacity parameter
		@include color-prop( color, rgba(0, 100, 100, 0.5) );
		
		// You can also manually set a background color for flat HEX color
		@include color-prop( background-color, #fdc, 0.3, #000 );
	}

###CSS:

	h1 {
		// Basic usage
		background-color: #fff4ef;
		background-color: rgba(255, 221, 204, 0.3);
		
		// CSS shorthand values work fine
		border-bottom: 10px solid #fbc092;
		border-bottom: 10px solid rgba(247, 129, 37, 0.5);
		
		// You can use an RGBA value and omit the opacity parameter
		color: #7fb1b1;
		color: rgba(0, 100, 100, 0.5);
		
		// You can also manually set a background color for flat HEX color
		background-color: #4c423d;
		background-color: rgba(255, 221, 204, 0.3);
	}
