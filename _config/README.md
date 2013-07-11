# Sass Configuration

This is a sample Compass configuration file that you can use with your Sass files. It's similar to what can be done in CodeKit (and tools like it) but via the command line.

To use:

1. Install Compass

    $ gem update --system
    $ gem install compass

2. Edit your configuration file to point to the correct directories and to add your own configuration elements.

3. Start compass

    $ compass watch ./ -e development -c config.rb
    
`-e` refers to the environment. It can be `development` or `production`. Default is `production`.
`-c` refers to the configuration file.

It's recommended to store this command as an alias.

All these details and more can be found in the documentation.

* [Compass Documentation](http://compass-style.org)
* [Sass Documentation](http://sass-lang.com/docs.html)
