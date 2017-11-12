<!--- GENERATED FILE, DO NOT EDIT --->
**Next Stop:** [First Test](./First.md#first-test)


# Overview

This tour shows how to use the `RubyTest` framework for testing the GitHub REST API.

This domain-specific GitHub REST API framework is layered onto the underlying RubyTest core framework, and implements:

- A domain-specific API client.
- Nested test sections that product corresponding nested log sections.
- Verifications and validations.
- Exception handling.
- Data objects, derived from robust base classes.
- (More to come).

A word about the final method called in each test, <code>log.assert_counts</code>.  These pages are assembled from text, code, and logs that are rebuilt frequently.  That is, each test is re-executed, and the code and refreshed log are patched into a text template.  We would want to know if the counts of verdicts, failures, and errors are not as expected, which would indicate that something is different, and likely wrong.  Therefore we assert the expected counts at the end of each test.

**Next Stop:** [First Test](./First.md#first-test)

