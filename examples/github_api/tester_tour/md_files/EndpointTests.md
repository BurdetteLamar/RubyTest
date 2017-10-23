<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Validating Nested Data Objects](./NestedDataValid.md#validating-nested-data-objects)

**Next Stop:** [GetLabels Test](./GetLabels.md#getlabels-test)


# Endpoint Tests

The next few stops will show how to test some GitHub REST API endpoints.

These endpoints will be:

- `GET /labels` - Get all labels.
- `GET /labels/:name` - Get a label.
- `POST /labels` - Create a label.
- `PATCH /labels/:name` - Update a label.
- `DELETE /labels/:name` - Delete a label.

Each of these endpoints is represented by an 'endpoint object' that corresponds precisely to the famed 'page object' used for testing web applications.

Each endpoint object has class method `verdict_call_and_verify_success` that does the work of interacting with the API and evaluating the response.

**Prev Stop:** [Validating Nested Data Objects](./NestedDataValid.md#validating-nested-data-objects)

**Next Stop:** [GetLabels Test](./GetLabels.md#getlabels-test)

