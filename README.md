# RubyTest

This project provides _working software_ to help with automated software testing.

The first major component is:
 
- [Example testing for a REST API](./examples/rest_api/RestAPI.md).

The testing is supported by:

- [Robust logging](./lib/log/log.rb).

Links to the other markdown documentation are at:

- [Contents](./Contents.md)

You can build the RDoc by cloning and running command

- <code>rake build:rerdoc</code>
  
The RDoc output will be in directory <code>html/</code>, with the index file at <code>html/index.html</html>.

You can also review all rake tasks by running command

- <code>rake -D</code>

or by visiting the documentation for the [Rakefile](./Rakefile.md).
