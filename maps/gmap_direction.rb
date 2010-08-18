#!/usr/bin/env ruby
# 
# devquiz maps API
#
require 'rubygems'
require 'uri'
require 'net/http'
require 'json'
require 'pp'

class GMapDirection

    RESERVED_CHARACTERS = /[^a-zA-Z0-9\-\.\_\~]/
        VERSION = '0.1'
    USER_AGENT = "TOOCHEAP_MAPS_DEVQUIZ_CLIENT/#{VERSION}"

    def initialize(from, to)
        raise TypeError if from.nil?
        raise TypeError if to.nil?
        @params = {
            'origin' => from,
            'destination' => to,
            'sensor' => false
        }
    end

    def range
        responce = _request(:get, create_map_uri)
        mdata = JSON.parse(responce.body.to_s)
        unless mdata['status'] =~ /OK/ 
            puts "Error had occured: #{mdata['status']}"
            puts "URI:#{create_map_uri}"
            raise
        end
        r = mdata['routes'][0]['legs'][0]['duration']['value'].to_i
        r
    end

    def create_map_uri(output='json')
        path = "http://maps.google.com/maps/api/directions/#{output}?" + encode_parameters(@params)
    end

    def _request(method, url, body = nil, headers = {})
        method = method.to_s
        url = URI.parse(url)
        request = create_http_request(method, url.request_uri, body, headers)
        Net::HTTP.new(url.host, url.port).request(request)
    end

    def escape(value)
        URI.escape(value.to_s, RESERVED_CHARACTERS)
    end

    def encode_parameters(params, delimiter = '&', quote = nil)
        if params.is_a?(Hash)
            params = params.map do |key, value|
                "#{escape(key)}=#{quote}#{escape(value)}#{quote}"
            end
        else
            params = params.map { |value| escape(value) }
        end
        delimiter ? params.join(delimiter) : params
    end

    def create_http_request(method, path, body, headers)
        method = method.capitalize.to_sym
        request = Net::HTTP.const_get(method).new(path, headers)
        request['User-Agent'] = USER_AGENT
        if method == :Post || method == :Put
            request.body = body.is_a?(Hash) ? encode_parameters(body) : body.to_s
            request.content_type = 'application/x-www-form-urlencoded'
            request.content_length = (request.body || '').length
        end
        request
    end
end
__END__
from = "35.185590,136.899060"
to = "35.686839,139.771438"
gmd = GMapDirection.new(from, to)
p gmd.range

