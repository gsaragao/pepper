// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function showNotification(success, message) {

  $("#divNotificacao").remove();

  var body = "<div id='divNotificacao' >";
  body += "<table border='1' width='100%'>";
  body += "<tr>";
  body += "<td id='tabelaNotificacao' align='center'>";
  body += message;
  body += "</td>";
  body += "</tr>";
  body += "</table>";
  body += "</div>";

  $(document.body).append(body);

  $("#divNotificacao").hide();
  $("#divNotificacao").css("position", "absolute");

  $("#tabelaNotificacao").css("font-weight", "bold");

  $("#tabelaNotificacao").css("font-size", "13px");
  $("#tabelaNotificacao").css("color", "white");
  $("#tabelaNotificacao").css("align", "center");
 
  $("#tabelaNotificacao").css("padding", "15px 200px 12px 160px");
  $("#divNotificacao").css("padding-left", "300px");
  $("#divNotificacao").css("top", "-1px");
  $("#divNotificacao").css("align", "center");
  $("#divNotificacao").slideDown("slow");
  $("#divNotificacao").maxZIndex();

  if (success) {
     $("#tabelaNotificacao").css("background-color", "#6D9C34");
  } else {
     $("#tabelaNotificacao").css("background-color", "#D43F3F");
  }

  setTimeout("hiddenNotification();", 2500);
}

function hiddenNotification() {
  $("#divNotificacao").slideUp();
}

$.maxZIndex = $.fn.maxZIndex = function(opt) {
  var def = { inc: 10, group: "*" };
  $.extend(def, opt);
  var zmax = 0;
  $(def.group).each(function() {
     var cur = parseInt($(this).css('z-index'));
     zmax = cur > zmax ? cur : zmax;
  });
  if (!this.jquery)
     return zmax;

  return this.each(function() {
     zmax += def.inc;
     $(this).css("z-index", zmax);
  });
};


function parseDoubleToMoedaPtBR (value) {
    var v = new String(value);
    v = v.replace(',', '.');
    v = (Math.round((v - 0) * 100)) / 100;
    v = (v == Math.floor(v)) ? v + ".00" : ((v * 10 == Math.floor(v * 10)) ? v + "0" : v);
    v = String(v);
    var ps = v.split('.');
    var whole = ps[0];
    var sub = ps[1] ? ',' + ps[1] : ',00';
    var r = /(\d+)(\d{3})/;
    while (r.test(whole)) {
        whole = whole.replace(r, '$1' + '.' + '$2');
    }
    v = whole + sub;
    if (v.charAt(0) == '-') {
        return '-$' + v.substr(1);
    }
    return v;
}

function alltrim(str) {
    if(str != null && str != ''){
        return str.replace(/^\s+|\s+$/g, '');
    }else{
        return '';
    }
}

function replaceAll(str, de, para) {

   var pos = str.indexOf(de);
   while (pos > -1) {
       str = str.replace(de, para);
       pos = str.indexOf(de);
   }

   return (str);
}

function Mask() {
   this.autoDetect = function() {
      jQuery(".mask-money").each(function() {
         jQuery(this).setMask({mask : '99,999.999.99', type : 'reverse', defaultValue : '+'});
      });
      jQuery(".mask-numeric-2").each(function() {
         jQuery(this).setMask({mask : '99'});
      });
      jQuery(".mask-date").each(function() {
         jQuery(this).setMask('date');
         jQuery(this).datepicker();
      });
   }
}