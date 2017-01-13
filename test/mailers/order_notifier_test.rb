require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /Dear Dave Thomas\r\nThank you for your recent order from The Pragmatic Store.\r\nYou ordered the following items:\r\nWe'll send you a separate e-mail when your order ships.\r\n/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match "<h3>Pragmatic Order Shipped</h3>\r\n<p>\r\n  This is just to let you know that we've shipped your recent order:\r\n</p>\r\n\r\n<table>\r\n  <tr><th colspan=\"2\">Qty</th><th>Description</th></tr>\r\n</table>\r\n", mail.body.encoded
  end

end
