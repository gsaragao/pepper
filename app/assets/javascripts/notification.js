/*
 * Notification (for jQuery)
 * version: 1.0 (08/10/2011)
 * @requires jQuery v1.6 or later
 *
 * Copyright 2011 Sérgio Souza [ sergio.lcs@gmail.com ]
 */

jQuery.Notification = function() {
   var main_div = "notifica";

   return {
      id: "notification_",
      timeout: 4000,
      auto_destroy: true,
      class:{
         success: "success",
         error: "error",
         confirm: "attention"
      },

      create: function(name) {
         var id = this.id + name;
         var html = '<div class="notification png_bg" id="' + id + '" style="display: none">';
         html += '     <div></div>';
         html += '</div>';
         $("#" + id).remove();
         $("#" + main_div).prepend(html);
      },

      show: function(name, message) {
         var id = "#" + this.id + name;
         this.create(name);
         $(id).addClass(name);
         $(id).children("div").html(message);
         $(id).show();
         if (this.auto_destroy)
            setTimeout("Notification.destroy('" + name + "');", this.timeout);
      },

      confirm: function(options) {
         this.auto_destroy = false;
         var name = this.class.confirm;
         var id = "#" + this.id + name;
         var btnYes = this.button.yes;
         var btnNo = this.button.no;
         var message = options.message + " " + btnYes + " / " + btnNo;
         this.show(name, message);

         $("#btnYes").click(function() {
            options.fn('yes');
            Notification.destroy(name);
            return false;
         });

         $("#btnNo").click(function() {
            options.fn('no');
            Notification.destroy(name);
            return false;
         });
      },

      success: function(message) {
         this.auto_destroy = true;
         this.show(this.class.success, message);
      },

      error: function(message) {
         this.auto_destroy = true;
         this.show(this.class.error, message);
      },

      attention: function(message) {
         this.auto_destroy = true;
         this.show(this.class.confirm, message);
      },

      destroy: function(name) {
         $("#" + this.id + name).slideUp();
         //$(id).remove();
      },

      button: {
         yes: "<a href='#' id='btnYes'>Sim</a>",
         no: "<a href='#' id='btnNo'>Não</a>"
      }
   }
}();

Notification = jQuery.Notification;