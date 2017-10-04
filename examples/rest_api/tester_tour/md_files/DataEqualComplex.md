<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Verifying a Simple Data Object](./DataEqualSimple.md)

**Next Stop:** [Validating a Simple Data Object](./DataValidSimple.md)


# Verifying a Complex Data Object

## Example Test

<code>data_equal_complex_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/user'

class DataEqualTest < BaseClassForTest

  def test_data_equal_complex
    prelude do |client, log|
      user_0 = User.get_first(client)
      user_1 = User.deep_clone(user_0)
      log.section('These are equal') do
        fail unless User.equal?(user_0, user_1)
        User.verdict_equal?(log, 'user equal', user_0, user_1, 'Using User.verdict_equal?')
      end
      log.section('These are not equal') do
        user_1.address.geo.lat += 1.0
        fail if User.equal?(user_0, user_1)
        User.verdict_equal?(log, 'user not equal', user_0, user_1, 'Using User.verdict_equal?')
      end
    end
  end

end
```

Notes:

- The test gets a known User, then clones it.
- We know that User is complex, so it's _necessary_ to use `deep_clone`, not `clone`.
- In the first section:
  - Method `User.equal?` returns `true`, but does no logging.
  - The `fail unless` proves that it worked.
  - Method `User.verdict_equal?` verifies and logs each value in the users.
- In the second section:
  - One value in the user is modified.  The changed value is in a nested object.
  - Method `User.equal?` returns `false`, but does no logging.
  - The `fail if ` proves that it worked.
  - Method `User.verdict_equal?` verifies and logs each value in the users.

## Log

<code>test_data_equal_complex.xml</code>
```xml
<data_equal_complex_test>
  <summary errors='1' failures='1' verdicts='1'/>
  <test_method name='data_equal_complex_test' timestamp='2017-10-04-Wed-12.44.28.422'>
    <section name='With ExampleRestClient'>
      <REST_API duration_seconds='1.497' method='GET' url='https://jsonplaceholder.typicode.com/users'>
        <execution timestamp='2017-10-04-Wed-12.44.28.429'>
          <uncaught_exception>
            <verdict_id>With ExampleRestClient</verdict_id>
            <class>RestClient::RequestFailed</class>
            <http_code>530</http_code>
            <http_body>
              &lt;!DOCTYPE html&gt; &lt;!--[if lt IE 7]&gt; &lt;html
              class=&quot;no-js ie6 oldie&quot; lang=&quot;en-US&quot;&gt;
              &lt;![endif]--&gt; &lt;!--[if IE 7]&gt; &lt;html class=&quot;no-js
              ie7 oldie&quot; lang=&quot;en-US&quot;&gt; &lt;![endif]--&gt;
              &lt;!--[if IE 8]&gt; &lt;html class=&quot;no-js ie8 oldie&quot;
              lang=&quot;en-US&quot;&gt; &lt;![endif]--&gt; &lt;!--[if gt IE
              8]&gt;&lt;!--&gt; &lt;html class=&quot;no-js&quot;
              lang=&quot;en-US&quot;&gt; &lt;!--&lt;![endif]--&gt; &lt;head&gt;
              &lt;title&gt;Origin DNS error | jsonplaceholder.typicode.com |
              Cloudflare&lt;/title&gt;&lt;/title&gt; &lt;meta
              charset=&quot;UTF-8&quot; /&gt; &lt;meta
              http-equiv=&quot;Content-Type&quot; content=&quot;text/html;
              charset=UTF-8&quot; /&gt; &lt;meta
              http-equiv=&quot;X-UA-Compatible&quot;
              content=&quot;IE=Edge,chrome=1&quot; /&gt; &lt;meta
              name=&quot;robots&quot; content=&quot;noindex, nofollow&quot;
              /&gt; &lt;meta name=&quot;viewport&quot;
              content=&quot;width=device-width,initial-scale=1,maximum-scale=1&quot; /&gt; &lt;link rel=&quot;stylesheet&quot; id=&quot;cf_styles-css&quot; href=&quot;/cdn-cgi/styles/cf.errors.css&quot; type=&quot;text/css&quot; media=&quot;screen,projection&quot; /&gt; &lt;!--[if lt IE 9]&gt;&lt;link rel=&quot;stylesheet&quot; id=&apos;cf_styles-ie-css&apos; href=&quot;/cdn-cgi/styles/cf.errors.ie.css&quot; type=&quot;text/css&quot; media=&quot;screen,projection&quot; /&gt;&lt;![endif]--&gt; &lt;style type=&quot;text/css&quot;&gt;body{margin:0;padding:0}&lt;/style&gt; &lt;!--[if lte IE 9]&gt;&lt;script type=&quot;text/javascript&quot; src=&quot;/cdn-cgi/scripts/jquery.min.js&quot;&gt;&lt;/script&gt;&lt;![endif]--&gt; &lt;!--[if gte IE 10]&gt;&lt;!--&gt;&lt;script type=&quot;text/javascript&quot; src=&quot;/cdn-cgi/scripts/zepto.min.js&quot;&gt;&lt;/script&gt;&lt;!--&lt;![endif]--&gt; &lt;script type=&quot;text/javascript&quot; src=&quot;/cdn-cgi/scripts/cf.common.js&quot;&gt;&lt;/script&gt; &lt;/head&gt; &lt;body&gt; &lt;div id=&quot;cf-wrapper&quot;&gt; &lt;div class=&quot;cf-alert cf-alert-error cf-cookie-error&quot; id=&quot;cookie-alert&quot; data-translate=&quot;enable_cookies&quot;&gt;Please enable cookies.&lt;/div&gt; &lt;div id=&quot;cf-error-details&quot; class=&quot;cf-error-details-wrapper&quot;&gt; &lt;div class=&quot;cf-wrapper cf-header cf-error-overview&quot;&gt; &lt;h1&gt; &lt;span class=&quot;cf-error-type&quot; data-translate=&quot;error&quot;&gt;Error&lt;/span&gt; &lt;span class=&quot;cf-error-code&quot;&gt;1016&lt;/span&gt; &lt;small class=&quot;heading-ray-id&quot;&gt;Ray ID: 3a89f3073c0c58bb &amp;bull; 2017-10-04 17:44:28 UTC&lt;/small&gt; &lt;/h1&gt; &lt;h2 class=&quot;cf-subheadline&quot; data-translate=&quot;error_desc&quot;&gt;Origin DNS error&lt;/h2&gt; &lt;/div&gt;&lt;!-- /.header --&gt; &lt;section&gt;&lt;/section&gt;&lt;!-- spacer --&gt; &lt;div class=&quot;cf-section cf-wrapper&quot;&gt; &lt;div class=&quot;cf-columns two&quot;&gt; &lt;div class=&quot;cf-column&quot;&gt; &lt;h2 data-translate=&quot;what_happened&quot;&gt;What happened?&lt;/h2&gt; &lt;p&gt;You&apos;ve requested a page on a website (jsonplaceholder.typicode.com) that is on the &lt;a data-orig-proto=&quot;https&quot; data-orig-ref=&quot;www.cloudflare.com/5xx-error-landing?utm_source=error_100x&quot; target=&quot;_blank&quot;&gt;Cloudflare&lt;/a&gt; network. Cloudflare is currently unable to resolve your requested domain (jsonplaceholder.typicode.com). &lt;/div&gt; &lt;div class=&quot;cf-column&quot;&gt; &lt;h2 data-translate=&quot;what_can_i_do&quot;&gt;What can I do?&lt;/h2&gt; &lt;p&gt;&lt;strong&gt;If you are a visitor of this website:&lt;/strong&gt;&lt;br /&gt;Please try again in a few minutes.&lt;/p&gt;&lt;p&gt;&lt;strong&gt;If you are the owner of this website:&lt;/strong&gt;&lt;br /&gt;Check your DNS settings. If you are using a CNAME origin record, make sure it is valid and resolvable. &lt;a href=&quot;https://support.cloudflare.com/hc/en-us/articles/234979888-Error-1016-Origin-DNS-error&quot;&gt;Additional troubleshooting information here.&lt;/a&gt;&lt;/p&gt; &lt;/div&gt; &lt;/div&gt; &lt;/div&gt;&lt;!-- /.section --&gt; &lt;div class=&quot;cf-error-footer cf-wrapper&quot;&gt; &lt;p&gt; &lt;span class=&quot;cf-footer-item&quot;&gt;Cloudflare Ray ID: &lt;strong&gt;3a89f3073c0c58bb&lt;/strong&gt;&lt;/span&gt; &lt;span class=&quot;cf-footer-separator&quot;&gt;&amp;bull;&lt;/span&gt; &lt;span class=&quot;cf-footer-item&quot;&gt;&lt;span data-translate=&quot;your_ip&quot;&gt;Your IP&lt;/span&gt;: 12.106.117.133&lt;/span&gt; &lt;span class=&quot;cf-footer-separator&quot;&gt;&amp;bull;&lt;/span&gt; &lt;span class=&quot;cf-footer-item&quot;&gt;&lt;span data-translate=&quot;performance_security_by&quot;&gt;Performance &amp;amp; security by&lt;/span&gt; &lt;a data-orig-proto=&quot;https&quot; data-orig-ref=&quot;www.cloudflare.com/5xx-error-landing?utm_source=error_footer&quot; id=&quot;brand_link&quot; target=&quot;_blank&quot;&gt;Cloudflare&lt;/a&gt;&lt;/span&gt; &lt;/p&gt; &lt;/div&gt;&lt;!-- /.error-footer --&gt; &lt;/div&gt;&lt;!-- /#cf-error-details --&gt; &lt;/div&gt;&lt;!-- /#cf-wrapper --&gt; &lt;script type=&quot;text/javascript&quot;&gt; window._cf_translation = {}; &lt;/script&gt; &lt;/body&gt; &lt;/html&gt;
            </http_body>
            <message>HTTP status code 530</message>
            <backtrace>
              <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:106:in `block (3 levels) in client_method'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:105:in `block (2 levels) in client_method'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:103:in `block in client_method'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:101:in `client_method'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:38:in `get'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_get.rb:9:in `call_and_return_payload'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/endpoints/users/get_users.rb:9:in `call_and_return_payload'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_endpoint.rb:11:in `call'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_resource.rb:73:in `get_all'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_resource.rb:78:in `get_first'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_equal_complex_test.rb:9:in `block in test_data_equal_complex'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_equal_complex_test.rb:8:in `test_data_equal_complex']]>
            </backtrace>
          </uncaught_exception>
        </execution>
      </REST_API>
      <section name='Count of errors (unexpected exceptions)'>
        <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='failed' volatile='true'>
          <exp_value>0</exp_value>
          <act_value>1</act_value>
          <exception>
            <class>Minitest::Assertion</class>
            <message>Expected: 0 Actual: 1</message>
            <backtrace>
              <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_equal_complex_test.rb:8:in `test_data_equal_complex']]>
            </backtrace>
          </exception>
        </verdict>
      </section>
    </section>
  </test_method>
</data_equal_complex_test>
```

- Each actual value, even one that's in a nested object, is verified in a separate verdict.  This makes evaluating the test execution unambiguous.
- In the first section, all verdicts pass.
- In the second section, one verdict fails.

**Prev Stop:** [Verifying a Simple Data Object](./DataEqualSimple.md)

**Next Stop:** [Validating a Simple Data Object](./DataValidSimple.md)

