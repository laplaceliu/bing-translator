# encoding: utf-8

require 'mechanize'
require 'json'
require 'open-uri'

module Translate
  def self.get_tokens(grant_type, scope_url, client_id, client_secret, auth_url)
    param_arr = {:grant_type    => grant_type,
                 :scope         => scope_url,
                 :client_id     => client_id,
                 :client_secret => client_secret
    }

    agent = Mechanize.new

    cert_store = OpenSSL::X509::Store.new
    cert_store.add_file 'cacert.pem'

    agent.cert_store = cert_store
    response = agent.post auth_url, param_arr

    res_hash = JSON.parse response.body

    if res_hash['access_token']
      return res_hash['access_token']
    else
      return nil
    end
  end

  def self.get_translation(trans_url, access_token, from, to, input)
    param_arr = {#'text'   => URI::encode(input.to_s),
                 :text   => input.to_s,
                 :to     => to.to_s,
                 :from   => from.to_s,
    }

    auth_header = {'Authorization' => 'Bearer ' + access_token}

    agent = Mechanize.new

    response = agent.get trans_url, param_arr, nil, auth_header
    response.xml.children.children.to_s
  end
end