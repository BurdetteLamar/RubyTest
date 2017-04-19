require_relative '../../lib/base_class'

class RestClient < BaseClass

  # Instantiate a client for the caller's block.
  Contract Log, Proc => nil
  def self.with(log)
    raise 'No block given' unless (block_given?)
    log.section('With %s' % self, :rescue) do
      client = self.new(log, im_ok_youre_not_ok = true)
      # Client should retrieve and log the API version if it's available.
      # (Here, it's not.)
      yield client
      # Client should calculate and log summary information here.
      # TBS.
    end
    nil
  end

  # Tests should use method with, above, not method new.
  Contract Log, Bool => nil
  def initialize(log, im_ok_youre_not_ok = false)
    raise RuntimeError('Call method with, not new') unless im_ok_youre_not_ok
    @base_url = 'https://jsonplaceholder.typicode.com'
    @log = log
    @uri = URI.parse(@base_url)
    nil
  end

  # Get.
  Contract ArrayOf[String], Maybe[ArrayOf[String]], Any => Or[String, Array, Hash]
  def get(url_elements, query_elements = [])
    client_method(__method__, url_elements, query_elements)
  end

  # Post.
  Contract ArrayOf[String], Maybe[ArrayOf[String]], Any => Or[String, Array, Hash]
  def post(url_elements, query_elements = [], parameters = nil)
    client_method(__method__, url_elements, query_elements, parameters)
  end

  # Put.
  Contract ArrayOf[String], Maybe[ArrayOf[String]], Any => Or[String, Array, Hash]
  def put(url_elements, query_elements = [], parameters = nil)
    client_method(__method__, url_elements, query_elements, parameters)
  end

  # Delete.
  Contract ArrayOf[String], Maybe[ArrayOf[String]], Any => Or[String, Array, Hash]
  def delete(url_elements, query_elements = [], parameters = nil)
    client_method(__method__, url_elements, query_elements, parameters)
  end

  # Do one of the above.
  Contract Symbol, ArrayOf[String], Maybe[ArrayOf[String]], Any => Or[String, Array, Hash]
  def client_method(rest_method, url_elements, query_elements = [], parameters = nil)
    response = nil
    url = File.join(@base_url, *url_elements)
    url = URI.escape(url)
    query_elements.each_with_index do |s, i|
      char = (i == 0) ? '?' : '&'
      url = '%s%s%s' % [url, char, s]
    end
    # Cannot allow uncaught exception in a log block.
    @log.section(:timestamp, :duration, :method => rest_method.to_s.upcase, :url => url) do
      unless parameters.nil?
        @log.put_element('parameters', parameters)
      end
    end

    args = Hash.new
    args.store(:method, rest_method)
    args.store(:url, url)
    case
      when [
          :delete,
          :get
      ].include?(rest_method)
      when [
          :post,
          :put
      ].include?(rest_method)
        headers = {
            :content_type => 'application/json',
        }

        parameters_json = parameters.to_json
        args.store(:payload, parameters_json)
        args.store(:headers, headers)
      else
        raise ArgumentError(rest_method)
    end

    args.store(:timeout, 60)

    log_retry = Proc.new do |exception, try, elapsed_time, next_interval|
      puts "#{exception.class}: '#{exception.message}'"
      puts "#{try} tries in #{elapsed_time} seconds and #{next_interval} seconds until the next try."
    end

    # noinspection RubyResolve
    Retriable.retriable on: RestClient::RequestTimeout, tries: 10, base_interval: 1, on_retry: log_retry do
      response = RestClient::Request.execute(args)
    end
    parser = JSON::Ext::Parser.new(response)
    parser.parse
  end

end