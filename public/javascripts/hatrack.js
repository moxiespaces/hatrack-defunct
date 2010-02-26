var Hatrack = {
  rack: $('#hatrack'),
  controls: $('#controls'),
  font_size: null,
  sprint_id: null,
  colors: ['yellow','black','green','red','white'] ,
  setup: function() {

    $('.add_hat').bind('click', Hatrack.addHat);
    $('.toggle').bind('click', Hatrack.toggleColor);

    for (var i in Hatrack.colors) {
      $('.hat.e.' + Hatrack.colors[i]).editable('/hats/update?sprint_id=' + Hatrack.sprint_id + '&type=' + Hatrack.colors[i], {
        type: 'textarea',submit: 'Save',cancel: 'Cancel', onblur: 'ignore' });
    }

    $('.green_hat div').editable('/hats/update_green_hat?sprint_id=' + Hatrack.sprint_id, {
        type: 'textarea',submit: 'Save',cancel: 'Cancel', onblur: 'ignore' });

    $('.fontSize').bind('click', Hatrack.fontSize);

    $('.date_input').datepicker();

    if (Hatrack.font_size) {
      $('#hatrack').css('font-size', Hatrack.font_size);
    }

  },

  addHat: function(event) {
    var color = event.target.parentNode.className.split(' ')[1];
    if ($('.hat.new.' + color).length > 0) {
      $('.hat.new.' + color).click();
      return false;
    }

    var id = Math.floor(Math.random() * 1111)

    $('#' + color + ' ul').append('<li class="hat_item"><div class="hat new ' + color + '" id="hat_' + id + '">Enter a hat</div></li>');
    var new_hat = $('#hat_' + id);
    new_hat.editable('/hats/create?sprint_id=' + Hatrack.sprint_id + '&type=' + color, {
      type: 'textarea',submit: 'Save',cancel: 'Cancel', onblur: 'ignore', callback:function(value, settings) {
        new_hat.parent('li').replaceWith(value);
        Hatrack.setup();
      }});

    new_hat.click();

    return false;
  },

  toggleColor: function(event) {
    $('#' + event.target.className.split(' ')[1]).toggle();
    return false;
  },


  view:function(event) {
    $('.view').attr('style', null);
    $('.view').removeClass('view');
    $('.note').bind('click', Hatrack.view);

    $(event.target).unbind('click');
    $(event.target).animate({position:'absolute',width:'400px',height: '400px',  left: 0,right: 0,  top: 0,bottom: 0, opacity: 1,margin: '0 auto'}).addClass('view');
  },

  save:function(hat, value, settings) {
    var type = this.className.split(' ')[1];
    var value = this.innerHTML;
    $.post('/hats/create', {'hat[type]': type, 'hat[body]': value});
    return  value;
  },

  fontSize: function(event) {
    var dir = event.target.className.split(' ')[1];
    switch (dir) {
      case 'reset':
        $('#hatrack').attr('style', null)
        break;
      case 'up':
        $('#hatrack').css('font-size', parseInt($('#hatrack').css('font-size')) + 1);
        break;
      case 'down':
        $('#hatrack').css('font-size', parseInt($('#hatrack').css('font-size')) - 1);
        break;
    }
    $.post('/sprint/set_font_size', {size:parseInt($('#hatrack').css('font-size')) });
  }
}



