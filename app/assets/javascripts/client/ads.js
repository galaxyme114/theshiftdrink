// (function() {
//   var gads = document.createElement('script'); gads.async = true; gads.type = 'text/javascript'; var useSSL = 'https:' == document.location.protocol;
//   gads.src = (useSSL ? 'https:' : 'http:') + '//www.googletagservices.com/tag/js/gpt.js';
//   var node = document.getElementsByTagName('script')[0]; node.parentNode.insertBefore(gads, node);
// })();

// var googletag = googletag || {}; googletag.cmd = googletag.cmd || [];

// googletag.cmd.push(function() {
//   var slot1 = googletag.defineSlot("/23019527/TSD_Skyscraper1", [300, 600],
//   "div-gpt-ad-1456175901503-0").addService(googletag.pubads());

//   var slot2 = googletag.defineSlot("/23019527/TSD_Thin_Skyscraper", [160, 600],
//   "div-gpt-ad-1456175901503-1").addService(googletag.pubads());

//   var slot3 = googletag.defineSlot("/23019527/TSD_Mobile", [320, 50],
//   "div-gpt-ad-1456175901503-2").addService(googletag.pubads());

//   googletag.pubads().enableSingleRequest();
//   googletag.enableServices();

//   googletag.display("div-gpt-ad-1456175901503-0");
//   googletag.display("div-gpt-ad-1456175901503-1");
//   googletag.display("div-gpt-ad-1456175901503-2");

//   function refreshAds() {
//     var identifier = $('.ad:visible').attr('id');

//     if ( identifier === 'div-gpt-ad-1456175901503-0') {
//       googletag.pubads().refresh([slot1]);
//     }

//     if ( identifier === 'div-gpt-ad-1456175901503-1') {
//       googletag.pubads().refresh([slot2]);
//     }

//     if ( identifier === 'div-gpt-ad-1456175901503-2') {
//       googletag.pubads().refresh([slot3]);
//       console.log("div-gpt-ad-1456175901503-2");
//     }

//     return 0;
//   };

//   var counter = 0;
//   var limit = 1;
  
//   $(document).on('click', '.next, .prev, .sm-fwd, .sm-prev', function() {
//     counter++;

//     if ( counter === limit ) {
//       counter = refreshAds();
//     };
//   });

//   $(document).on('swiperight swipeleft', 'body', function() {
//     counter++;

//     if ( counter === limit ) {
//       counter = refreshAds();
//     };
//   });
// });
