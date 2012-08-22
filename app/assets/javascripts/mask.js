(function ($) {

   Mask = $.fn.Mask = function () {
      this.autoDetect = function () {
         $(".mask-money").each(function () {
            $(this).setMask({mask:'99,999.999.99', type:'reverse'});
         });
         $(".mask-money-with-negative").each(function () {
            $(this).setMask({mask:'99,999.999.99', type:'reverse', defaultValue:'+'});
         });
         $(".mask-numeric-2").each(function () {
            $(this).setMask({mask:'99'});
         });
         $(".mask-numeric-3").each(function () {
            $(this).setMask({mask:'999'});
         });
         $(".mask-numeric-10").each(function () {
            $(this).setMask({mask:'9999999999'});
         });
         $(".mask-date").each(function () {
            $(this).setMask('date');
            $(this).datepicker({dateFormat : 'dd/mm/yy'});
         });
         $(".mask-cnpj").each(function () {
            $(this).setMask('cnpj');
         });
         $(".mask-phone").each(function () {
            $(this).setMask('phone');
         });
      }
   };

})(jQuery);


