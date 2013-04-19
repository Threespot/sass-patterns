# Corner Lift Shadow Effect

## The Functions:

    // Corner lift shadows
    // NOTE: Must set an opaque background color on target element
    // Reference: http://www.readitsideways.com/css3_demos/shadows/
    @mixin corner-lift( $color: rgba(0, 0, 0, 0.2), $angle: 3deg, $bottom-offset: 14px ) {
        $height: 40px; // Default max height shadow can be
        position: relative;
        &:before,
        &:after {
            bottom: 22px - $bottom-offset;
            content: '\0020';
            height: $height;
            max-width: 50%;
            position: absolute;
            width: 50%;
            z-index: -1;
            @include box-shadow( 0 15px 5px $color );
        }
        &:before {
            @include transform( skew( -4deg, -$angle ) );
            left: 1px;
        }
        &:after {
            @include transform( skew( 4deg, $angle ) );
            right: 1px;
        }
    }

## Usage

###Sass:

    .box {
      @include corner-lift( rgba(0, 0, 0, 0.2), 3deg, 10px );
  
      /* Must set an opaque background color, but doesn't have to be white */
      background-color: #fff;
  
      /* Demo styles */
      box-shadow: 0px 0px 1px 1px rgba(0, 0, 0, 0.2);
      font-family: 'Calibri', sans;
      height: 100px;
      margin: 3em auto;
      padding: 1.5em;
      text-align: center;
      width: 300px;
    }

###CSS:

    .box {
      position: relative;
      background-color: #fdfdfd;
    }
    
    .box:before,
    .box:after {
      bottom: 12px;
      content: '\0020';
      height: 40px;
      max-width: 50%;
      position: absolute;
      width: 50%;
      z-index: -1;
      box-shadow: 0 15px 5px rgba(0, 0, 0, 0.2);
    }
    
    .box:before {
      -webkit-transform: skew(-4deg, -3deg);
      -moz-transform: skew(-4deg, -3deg);
      -ms-transform: skew(-4deg, -3deg);
      -o-transform: skew(-4deg, -3deg);
      transform: skew(-4deg, -3deg);
      left: 1px;
    }
    
    .box:after {
      -webkit-transform: skew(4deg, 3deg);
      -moz-transform: skew(4deg, 3deg);
      -ms-transform: skew(4deg, 3deg);
      -o-transform: skew(4deg, 3deg);
      transform: skew(4deg, 3deg);
      right: 1px;
    }

**Reference**: [Better CSS lifted corner shadows](http://www.readitsideways.com/css3_demos/shadows/)