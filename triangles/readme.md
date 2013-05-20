# Corner Lift Shadow Effect

## The Functions:

    // Sass Triangle Mixin
    // Source: http://minimalmonkey.com/sass-triangle-mixin/
    // Examples: http://codepen.io/minimalmonkey/pen/KIaGD
    @mixin arrows( $width: 20px, $height: 20px, $direction: up, $color: white ) {
    	height: 0;
    	width: 0;
    
    	// Right
    	@if ( $direction == right ) {
    		border-top: $height/2 solid transparent;
    		border-bottom: $height/2 solid transparent;
    		border-left: $width solid $color;
    	}

    	// Left
    	@if ( $direction == left ) {
    		border-top: $height/2 solid transparent;
    		border-bottom: $height/2 solid transparent;
    		border-right: $width solid $color;
    	}

    	// Up
    	@if ( $direction == up ) {
    		border-left: $width/2 solid transparent;
    		border-right: $width/2 solid transparent;
    		border-bottom: $height solid $color;
    	}

    	// Down
    	@if ( $direction == down ) {
    		border-left: $width/2 solid transparent;
    		border-right: $width/2 solid transparent;
    		border-top: $height solid $color;
    	}
    }

## Usage
Examples on CodePen http://codepen.io/minimalmonkey/pen/KIaGD

**Reference**: [http://minimalmonkey.com/sass-triangle-mixin/](http://minimalmonkey.com/sass-triangle-mixin/)