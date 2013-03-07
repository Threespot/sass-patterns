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
		$weight: alpha($color) * 100%;
		// Mix new flat color
		@return mix( get-rgb($color), $bg-color, $weight );
	}

	// Set old IE flag if not already defined
	$old-ie: false !default;

	// Convert any color format to RGBA, with fallback for old IE and optional background color to mix
	// Usage: color-alpha( #abc, 0.5) ) => rgba(170, 187, 204, 0.5) or #d4dde5 for old IE
	@function color-alpha( $color, $opacity: none, $bg-color: white ) {
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
		@if $old-ie {
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


## Usage

Simply pass a color value and opacity <code>color-alpha( $color, $opacity)</code>


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
