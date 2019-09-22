# encoding: utf-8
require 'rubygems'

module HawkAuthentication
	def verify_hawk(headers,method,path)
		secret_key = "werxhqb98rpaxn39848xrunpaw3489ruxnpa98w4rxn"
		res = Hawk::Server.authenticate(headers,method: method,host: '127.0.0.1',port: 3000,path: path,content_type => "text/plain",:credentials_lookup => lambda { |id| id == headers[:id] ? headers : nil },:nonce_lookup => lambda { |nonce| },payload: secret_key)
		res
	end
end