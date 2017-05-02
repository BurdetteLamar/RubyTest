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

Each endpoint found in the target REST API is encapsulated by an endpoint class in this test example.

These endpoint classes implement an _endpoint object pattern_ that corresponds directly to the well-known [page object pattern](http://www.assertselenium.com/automation-design-practices/page-object-pattern).

Each endpoint class has three methods:

- <code>self.call</code>:  sends request and returns data object(s) created from response.
- <code>self.call_and_return_payload</code>:  sends request and returns both data object(s) and parsed JSON.
- <code>self.verdict_call_and_verify_success</code>:  sends request and verifies response.

The endpoint URLs and their behaviors are _very_ consistent, which makes it easy to implement base classes that do most of the work:

- [BaseClassForDeleteId](./endpoints/base_classes/base_class_for_delete_id.rb)
- [BaseClassForGet](./endpoints/base_classes/base_class_for_get.rb)
- [BaseClassForGetId](./endpoints/base_classes/base_class_for_get_id.rb)
- [BaseClassForPost](./endpoints/base_classes/base_class_for_post.rb)
- [BaseClassForPutId](./endpoints/base_classes/base_class_for_put_id.rb)

Each of these base classes implements methods <code>self.call_and_return_payload</code> and <code>self.verdict_call_and_verify_success</code.

Method <code>self.call</code> is implemented in a higher-level base class:

- [BaseClassForEndpoint](./endpoints/base_classes/base_class_for_endpoint.rb)

## Tests

### Base Class for Test

If you've read this far, you won't be surprised that there's a:

- [BaseClassForTest](./tests/base_class_for_test.rb)

The class is derived from class <code>Minitest::Test</code>, in Ruby gem

- [minitest](https://rubygems.org/gems/minitest)

Its only method, <code>prelude</code> accepts a block, and yields with instances of [Log](../../lib/log/log.rb) and [ExampleRestClient](./example_rest_client.rb) for use in the block.

### Test Classes

Each test class performs testing for one of the REST API resources:

- [AlbumsTest](./tests/albums_test.rb)
- [CommentsTest](./tests/comments_test.rb)
- [PhotosTest](./tests/photos_test.rb)
- [PostsTest](./tests/posts_test.rb)
- [TodosTest](./tests/todos_test.rb)
- [UsersTest](./tests/users_test.rb)

Each test method uses <code>Log</code>'s nested sections to give the test structure and improve readability.  The sections are reflected in the created XML log.

If you have cloned this project, you can run the tests and produce logs by typing command:

- <code>rake examples:rest_api</code>
