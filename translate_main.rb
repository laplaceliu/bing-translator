# encoding: utf-8

require './translate'

client_id      = "1111111111"
client_secret  = "2222222222"
auth_url       = "https://datamarket.accesscontrol.windows.net/v2/OAuth2-13/"
scope_url      = "http://api.microsofttranslator.com"
grant_type     = "client_credentials"

access_token = Translate::get_tokens(grant_type, scope_url, client_id, client_secret, auth_url)
if !access_token then
  exit
end

trans_url = "http://api.microsofttranslator.com/v2/Http.svc/Translate"
from = "zh-CHS"
to   = "en"
input = "中文单词，中文句子 加几个 空格 行吗？"
#input = "something has wrong."
translation = Translate::get_translation(trans_url, access_token, from, to, input)

puts translation