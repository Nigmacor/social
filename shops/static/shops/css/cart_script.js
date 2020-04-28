$(document).ready(function(){
  var form = $('.product-card-views');
  var button = $('.btn');

  function show_cart() {
    // $('.cart-items').toggleClass('d-none');
    $('.cart-items').removeClass('d-none');
  }

  $('.cart-container').on('click', function(e){
    e.preventDefault();
    show_cart();
  })


  form.on('submit', function(e) {
    e.preventDefault();
    var cur_form = this;
    var product_id = cur_form.id.slice(5);
    var submit_btn = $(`#submit_btn_${product_id}`);
    var quant = cur_form.quantity.value;
    var delete_url = $('.delete-url').val();
    var title = submit_btn.data("title");
    var price = submit_btn.data("price");
    var url = $(`#${cur_form.id}`).attr("action");
    var update = cur_form.update.value;
    var csrf_token = cur_form.csrfmiddlewaretoken.value;
    var data = {};
    data.quantity = quant;
    data.update = update;
    data["csrfmiddlewaretoken"] = csrf_token;
    $.ajax({
      url: url,
      type: 'POST',
      data: data,
      cache: true,
      success: function (data) {
        console.log('OK');
      },
      error: function () {
        console.log('error');
      },
    })

    $('.cart-items ul').append('<li>'+title+', '+quant+'шт. '+'по ' + price +' руб. ' +
    `<a class="delete-item" href="${delete_url}${product_id}"> x</a>` +
    '</li>')

  })


  $(document).on('click', '.delete-item', function (e) {
    e.preventDefault();
    var del_buttun = $(this)
    del_buttun.closest('li').remove();
    $.ajax({
      url: del_buttun.attr("href"),
      type: 'GET',
      cache: true,
      success: function () {
        console.log('delete is OK');
      },
      error: function () {
        console.log('error');
      },
    })
  })
});
