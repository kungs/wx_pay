require 'digest/md5'
require 'digest/sha1'

module WxPay
  module Sign
    def self.generate(params)
      key = params.delete(:key)

      query = params.sort.map do |key, value|
        "#{key}=#{value}"
      end.join('&')

      Digest::SHA1.hexdigest("#{query}&key=#{key || WxPay.key}").upcase
    end

    def self.verify?(params)
      params = params.dup
      sign = params.delete('sign') || params.delete(:sign)

      generate(params) == sign
    end
  end
end
