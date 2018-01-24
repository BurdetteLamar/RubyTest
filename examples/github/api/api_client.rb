require 'json'
require 'rest-client'
require 'retriable'
require 'uri'

require_relative '../../../lib/base_classes/base_class'

class ApiClient < BaseClass

  attr_accessor :log

  # Instantiate a client for the caller's block.
  Contract Log, String, String, String, Proc => nil
  def self.with(log, repo_username, repo_password, repo_name)
    raise 'No block given' unless (block_given?)
    client = self.new(log, repo_username, repo_password, repo_name, im_ok_youre_not_ok = true)
    # Client should retrieve and log the API version if it's available.
    # (Here, it's not.)
    yield client
    # Client should calculate and log summary information here.
    # TBS.
    nil
  end

  def initialize(log, repo_username, repo_password, repo_name, im_ok_youre_not_ok = false)
    raise RuntimeError('Call method with, not new') unless im_ok_youre_not_ok
    @repo_username = repo_username
    @repo_password = repo_password
    @repo_name = repo_name
    @base_url = 'https://api.github.com'
    @uri = URI.parse(@base_url)
    self.log = log
  end

  def repo_url_elements
    [
        'repos',
        @repo_username,
        @repo_name,
    ]
  end

  # Get.
  Contract Array, Maybe[Hash] => Or[Array, Hash]
  def get(url_elements, query_elements)
    client_method(__method__, url_elements, query_elements, parameters = {})
  end

  # Post.
  Contract Array, Hash, Hash => Hash
  def post(url_elements, query_elements, parameters)
    client_method(__method__, url_elements, query_elements, parameters)
  end

  # Patch.
  Contract Array, Hash, Hash => Hash
  def patch(url_elements, query_elements, parameters)
    p ['URL ELEMENTS', url_elements]
    client_method(__method__, url_elements, query_elements, parameters)
  end

  # Delete.
  Contract Array, Hash => nil
  def delete(url_elements, query_elements)
    client_method(__method__, url_elements, query_elements, parameters = {})
  end

  private

  # Do one of the above.
  Contract Symbol, Array, Hash, Hash => Or[String, Array, Hash, nil]
  def client_method(rest_method, url_elements, query_elements, parameters)
    url = File.join(@base_url, *url_elements)
    query_elements.to_a.each_with_index do |pair, i|
      char = (i == 0) ? '?' : '&'
      url += '%s%s=%s' % [char, *pair]
    end
    url = URI.escape(url)
    args = Hash.new
    args.store(:method, rest_method)
    args.store(:url, url)
    args.store(:user, @repo_username)
    args.store(:password, @repo_password)
    case
      when [
          :delete,
          :get
      ].include?(rest_method)
      when [
          :post,
          :patch
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
    require_relative '../../../lib/helpers/debug_helper'
    DebugHelper.printf(args)

    log_retry = Proc.new do |exception, try, elapsed_time, next_interval|
      puts "#{exception.class}: '#{exception.message}'"
      puts "#{try} tries in #{elapsed_time} seconds and #{next_interval} seconds until the next try."
    end

    response = nil
    # Cannot allow an uncaught exception in a log section; would not close section properly.
    exception = nil
    log.put_element(self.class.name, :method => rest_method.to_s.upcase, :url => url) do
      log.put_element('parameters', parameters) unless parameters.empty?
      log.put_element('execution', :timestamp, :duration) do
        begin
          # noinspection RubyResolve
          Retriable.retriable on: RestClient::RequestTimeout, tries: 10, base_interval: 1, on_retry: log_retry do
            response = RestClient::Request.execute(args)
          end
        rescue => x
          exception = x
        end
      end
    end
    # Now we're outside the log block.
    raise exception if exception
    return nil if response.size == 0
    # RubyMine inspection thinks this should have no argument.
    # noinspection RubyArgCount
    parser = JSON::Ext::Parser.new(response)
    parser.parse
  end

end
