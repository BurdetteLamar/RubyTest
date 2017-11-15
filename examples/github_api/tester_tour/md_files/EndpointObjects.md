<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Existence Methods](./Existence.md#existence-methods)

**Next Stop:** [Endpoint Tests](./EndpointTests.md#endpoint-tests)


# Endpoint Objects

In testing web applications, the _page object design pattern_ has become justifiably famous.  Its job is classic data hiding:  each such object encapsulates an HMTL page.

The corresponding object for testing REST APIs is the _endpoint object_, which fully encapsulates a REST API endpoint.

And that is how this framework implements access to API endpoints:  via endpoint objects.  Each endpoint in encapsulated by its own endpoint class.

Each endpoint class has method `self.verdict_call_and_verify_success`, which may be used in a test.  Typically, that method accepts the client and zero or more data objects.

Examples:

- `GetLabels.verdict_call_and_verify_success(client)`
- `GetLabelsName.verdict_call_and_verify_success(client, label)`
- `PostLabelsName.verdict_call_and_verify_success(client, label)`
- `PatchLabelsName.verdict_call_and_verify_success(client, label)`
- `DeleteLabelsName.verdict_call_and_verify_success(client, label)`

Each of these methods defines what _success_ means (encapsulation!), and each performs and logs the actual verifications.

**Prev Stop:** [Existence Methods](./Existence.md#existence-methods)

**Next Stop:** [Endpoint Tests](./EndpointTests.md#endpoint-tests)

