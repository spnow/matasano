# coding: ascii
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'minitest/autorun'
require 'cryptopals/block'

class TestBlock < Minitest::Test
  def test_pkcs7_pad
    assert_equal "YELLOW SUBMARINE",          'YELLOW SUBMARINE'.pkcs7_pad(16)
    assert_equal "YELLOW SUBMARIN\x01",       'YELLOW SUBMARIN'.pkcs7_pad(16)
    assert_equal "YELLOW SUBMARI\x02\x02",    'YELLOW SUBMARI'.pkcs7_pad(16)
    assert_equal "YELLOW SUBMAR\x03\x03\x03", 'YELLOW SUBMAR'.pkcs7_pad(16)
    assert_equal "YELLOW SUBMAR\x03\x03\x03", 'YELLOW SUBMAR'.pkcs7_pad(8)
  end

  def test_pkcs7_check
    assert_equal 'ICE ICE BABY',      "ICE ICE BABY\x04\x04\x04\x04".pkcs7_check
    assert_equal "ICE ICE BABY\x01",  "ICE ICE BABY\x01\x03\x03\x03".pkcs7_check

    assert_raises(Cryptopals::PaddingError) { "ICE ICE BABY\x05\x05\x05\x05".pkcs7_check }
    assert_raises(Cryptopals::PaddingError) { "ICE ICE BABY\x01\x02\x03\x04".pkcs7_check }
  end
end
