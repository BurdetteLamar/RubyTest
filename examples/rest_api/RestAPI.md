# REST API Test Example

The example REST API test uses:
 
- [JSONPlaceholder](http://jsonplaceholder.typicode.com):  "Fake Online REST API for Testing and Prototyping."

## The Client

The REST API client used in this testing is:

- [ExampleRestClient](./example_rest_client.rb)

It has methods corresponding to some HTTP methods:

- <code>delete</code>
- <code>get</code>
- <code>post</code>
- <code>put</code>

It also has method

- <code>self.with</code>

which should be used instead of method <code>new</code>.  The method takes a block, and yields with an instance of <code>ExampleRestClient</code>, which the block can then use for testing.

## Data

### Data Classes

The testing here uses data classes that correspond to JSONPlaceholder data structures.

Each data class is derived from:

- [BaseClassForData](../../lib/base_classes/base_class_for_data.rb)

which has these methods:

- <code>self.verdict_equal?</code>
- <code>log</code>
- <code>to_hash</code>

### Resource Data Classes

The testing here uses data classes that correspond to the JSONPlaceholder resources:

- [Album](./data/album.rb)
- [Comment](./data/comment.rb)
- [Photo](./data/photo.rb)
- [Post](./data/post.rb)
- [Todo](./data/todo.rb)
- [User](./data/user.rb)

Each resource data class has these instance methods:

- <code>initialize</code>
- <code>verdict_valid?</code>: validates the _form_ (but not the _correctness_) of its data.

Each resource data class is derived from:

- [BaseClassForResource](./data/base_class_for_resource.rb)

which has these existence methods:

- <code>self.exist?</code>
- <code>self.verdict_exist?</code>
- <code>self.verdict_not_exist?</code>

along with CRUD methods:

- <code>self.create</code>
- <code>self.read</code>
- <code>self.update</code>
- <code>self.delete</code>

and a couple of other convenience methods:

- <code>self.get_all</code>
- <code>self.get_first</code>

### More Data Classes

Additional data classes correspond to data structures that are not themselves resources, but instead are embedded in resource data:

- [Address](address./data/.rb)
- [Company](company./data/.rb)
- [Geo](geo./data/.rb)

## Endpoints

Each endpoint in the target REST API is encapsulated by an endpoint class.

These endpoint classes implement an _endpoint object pattern_ that corresponds directly to the well-known [page object pattern](http://www.assertselenium.com/automation-design-practices/page-object-pattern).

## Tests




