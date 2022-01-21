var mobile = ($('.ad-mobile').is(":visible") || $('.ad-tablet').is(":visible"));
var step = 1;

$(mobile ? ".arrow" : ".swipe").css("display", "none");

function retrieveInt(string) {
  return parseInt(string.match(/[0-9 , \.]+/g)[0]);
};

function isInteger(x) {
  return x % 1 === 0;
};

function resizeImageMaps() {
	var aspect_ratio = 1536 / $('.center > img').width();
	var overlays = $('.hyperlink');
  $.each(overlays, function() {
    $(this).css({
			'left':   $(this).data('left') / aspect_ratio,
			'top':    $(this).data('top') / aspect_ratio,
			'width':  $(this).data('width') / aspect_ratio,
			'height': $(this).data('height') / aspect_ratio
		})
  });
  $('.center .map').css('margin', $('.center > img').css('margin'));
};

function setTitlePic(object) {
	if (mobile)
		$("#title_pic img").attr("src", $(object).attr('title_pic'));
};

function openCommentsTextTab() {
  	TweenLite.to(".comments-tab", .25, {ease: Power0.easeNone, "-webkit-transform": "translateY(-200%)"});
  	TweenLite.to("#bottom-bar .navigation ul.left-navigation img", .25, {ease: Power0.easeNone, opacity: 1, "-webkit-transform": "translateX(-" + (mobile ? 65 : 20) + "%)"});
};

function closeCommentsTextTab() {
  	TweenLite.to(".comments-tab", .25, {ease: Power0.easeNone, "-webkit-transform": "translateY(0)"});
	TweenLite.to("#bottom-bar .navigation ul.left-navigation img", .25, {ease: Power0.easeNone, opacity: 0, "-webkit-transform": "translateX(-0%)"});
};

function startCornerPopUp() {
	var stage = Cookies.get('sd-followers-prompt-stage');
	if ($("#container.material")[0] != undefined)
		return ;
	if (stage === undefined)
	{
		Cookies.set('sd-followers-prompt-stage', 1, { expires: 999});
		stage = 1;
	}
	stage = parseInt(stage);
	if (stage < 4 && !(stage == 3 && $('.followers .stage3')[0] === undefined)) {
		TweenLite.to(".followers", .25, {ease: Power0.easeNone, "-webkit-transform": "translateX(-450px)"});
		$('.followers .stage' + stage).css('display', 'block');
	}
	else {
		$('.followers').css('display', 'none');
	};
};

function handleCornerPopUp(pageTurns) {
	if (!mobile)
	{
		if (pageTurns == 2)
			startCornerPopUp();
	}
	else
	{
		// Manually sets on/off cornerPopUp's every 3 steps for mobile
		if (pageTurns % 3 == 0 && pageTurns <= 12)
			TweenLite.to(".followers", .25, {ease: Power0.easeNone, "-webkit-transform": "translateX(0)"});
		setTimeout(function(){
			if (pageTurns == 3)
			{
				Cookies.set('sd-followers-prompt-stage', 1, { expires: 999})
				startCornerPopUp();
			}
			else if (pageTurns == 6)
			{
				$('.followers .stage1').css('display', 'none');
				Cookies.set('sd-followers-prompt-stage', 2, { expires: 999})
				startCornerPopUp();
			}
			else if (pageTurns == 9)
			{
				$('.followers .stage2').css('display', 'none');
				Cookies.set('sd-followers-prompt-stage', 3, { expires: 999})
				startCornerPopUp();
			}
			else if (pageTurns == 12)
				Cookies.set('sd-followers-prompt-stage', 4, { expires: 999})

		}, 500);
	}
}

$(function() {

	if (mobile)
	{
		var options = {
			page_speed: 375,
      tweenSpeed: .25
		}
	}
	else {
		var options = {
			page_speed: 750,
			arrow_opacity: 0.6,
      tweenSpeed: .25
		}
	}

  var Issue = {

    container: $('#container'),

    nextBtn: $('.sm-fwd, .next'),
    prevBtn: $('.sm-prev, .prev'),

    articleContents: {},

		promise: null,

    pages: [],

    pageTurns: 0,

    init: function(issue_id, position, pages) {
      this.issue_id = issue_id;
      this.position = parseInt(position);
			this.pages    = pages;

      this.processFirstPages();
      return this;
    },

		animateArrows: function() {
			$(".arrow-offset").on("mouseover", function() {
				$(".arrow").css("opacity", options.arrow_opacity);
			})
			$(".arrow-offset").on("mouseleave", function() {
				$(".arrow").css("opacity", 0);
			})
		},

		manageCommentsTextPopUp: function(next) {
			if ($("#container.material")[0] != undefined)
				return ;
			next_next = next.next('.box');
			next_next_next = next_next.next('.box');
			if ((parseInt(next_next.find('img').attr("data-article")) != parseInt(next_next.next('.box').find('img').attr("data-article"))) &&
			(!['cover', 'survey', 'about-us', 'advertise-with-us', 'share-or-die'].includes($(next[0]).find('img')[0].alt)))
			{
				step = 1;
				clearTimeout(Issue.promise);
				Issue.promise = setTimeout(function(){
					openCommentsTextTab();
				}, 3000);
			}
			else
			{
				step++;
				if(step != 2)
					clearTimeout(Issue.promise);
			}
		},

		animateMobileSwipeIcon: function(speed, length) {
			var op = ($('.swipe').css("opacity") == 0 ? 0.8 : 0);
			TweenLite.to(".swipe", .25, {ease: Power0.easeNone, opacity: op});
		},

		// Animates Slide-in of all panels and boxes
		// If it's a mobile (determined on top), show
		// mobile ad and start displaying arrows.
		// t - 1s 	- Page
		// t - 2s 	- Ad and navigation
		// t - 2.5s - Bottom navigation
		// t - 3s 	- Arrows (or swipe img if mobile)
		animateOnboarding: function() {
			var from_auth = location.search.includes("origin=auth");
			var comments_link = $('#toggle-comments > a');
			var promise1 = 0;
			setTimeout(function() {
				if ($('#box' + Issue.position).css("left") != "125px")
				{
          TweenLite.to("#box" + Issue.position, options.tweenSpeed, {ease: Power0.easeNone, opacity: 1, "-webkit-transform": "translateX(-" + $(window).width() + "px)"});
					if (!mobile)
					{
						promise1 = setTimeout(function() {
              TweenLite.to(".arrow", options.tweenSpeed, {ease: Power0.easeNone, opacity: options.arrow_opacity});
						}, 200);
					}
				}
			}, 1000);
			setTimeout(function() {
				if (!mobile)
        {
					if (!navIsOpen())
          {
            from_auth ? comments_link.click() : openNav();
          }
          TweenLite.to(".ad-wrapper", options.tweenSpeed, {ease: Power0.easeNone, "-webkit-transform": "translateX(-180px)"});
				}
				else
				{
					if (Cookies.get('mobile_animation') != 'true')
					{
						setTimeout(function() {
							from_auth ? comments_link.click() : openNav();
							setTimeout(function() {
								closeNav();
								Cookies.set('mobile_animation', 'true', { expires: 1 });
							}, 2000);
						}, 1500);
					}
          TweenLite.to(".ad-mobile", options.tweenSpeed, {ease: Power0.easeNone, "-webkit-transform": "translateY(100px)"});
          TweenLite.to(".ad-mobile2", options.tweenSpeed, {ease: Power0.easeNone, "-webkit-transform": "translateY(100px)"});
				}
        TweenLite.to(".subs_free", options.tweenSpeed, {ease: Power0.easeNone, opacity: 1});
			}, 3000);
			var promise = 0;
			setTimeout(function() {
				openBottomBar();
			}, 3000)

			setTimeout(function() {
				if (mobile)
				{
					promise1 = setTimeout(function() {
						if (Cookies.get('swiped') != 'true')
						{
              TweenLite.to(".swipe", options.tweenSpeed, {ease: Power0.easeNone, opacity: 0.8});
							promise = setInterval(function () {
								Issue.animateMobileSwipeIcon(500, 50);
							}, 7500);
						}
					}, 3000);
				}
				$(document).on('swipeleft', 'body', function(){
					clearTimeout(promise1);
					clearInterval(promise);
				});
			}, 2000);
		},

    nextPage: function() {
      $box = $('#box' + this.position);
      $next = $box.next('.box');
			Issue.animateArrows();
			Cookies.set('swiped', 'true', { expires: 1 });
      TweenLite.to(".swipe", options.tweenSpeed, {ease: Power0.easeNone, opacity: 0});

      TweenLite.to($box, options.tweenSpeed, {
        ease: Power0.easeNone,
        opacity: 0,
        "-webkit-transform": "translateX(" + (parseInt($box.css("transform").split(",")[4]) - $(window).width() - $box.position().left) + "px)"
      });

      TweenLite.to($next, options.tweenSpeed, {
        ease: Power0.easeNone,
        opacity: 1,
        "-webkit-transform": "translateX(" + (parseInt($next.css("transform").split(",")[4]) + totalOffset() - $next.position().left) + "px)"
      });

      $box.removeClass('center');
      $next.addClass('center');

      if ( $next.find('img').data('interstitial') == true ) {
        this.triggerInterstitial();
      };
			var last = $('.box').last();
			var name = retrieveInt(last.attr('id')) + 1;
      var page = this.pages.filter(function(obj) {
        return obj.master_position == name
      });

      if ( page[0] !== undefined ) {
        var element = $('<div id="box'+name+'" class="box"><img src="" alt="" usemap=""><div class="map"></div></div>');
        last.after(element);
        this.setPageAttributes(element.find('img'), page[0], false);
      };
			Issue.manageCommentsTextPopUp($next);
      this.position++;
      this.pageTurns++;
			handleCornerPopUp(this.pageTurns);
    },

    previousPage: function() {
      $box = $('#box' + this.position);
      $prev = $box.prev('.box');

      TweenLite.to($box, options.tweenSpeed, {
        ease: Power0.easeNone,
        opacity: 0,
        "-webkit-transform": "translateX(" + (parseInt($box.css("transform").split(",")[4]) + $(window).width() - $box.position().left) + "px)"
      });

      TweenLite.to($prev, options.tweenSpeed, {
        ease: Power0.easeNone,
        opacity: 1,
        "-webkit-transform": "translateX(" + (parseInt($prev.css("transform").split(",")[4]) + totalOffset() - $prev.position().left) + "px)"
      });

      $box.removeClass('center');
      $prev.addClass('center');

      if ( $prev.find('img').data('interstitial') === true ) {
        this.triggerInterstitial();
      };

			var first = $('.box').first();
      var name = retrieveInt(first.attr('id')) - 1;

      var page = this.pages.filter(function(obj) {
        return obj.master_position == name
      });

      if ( page.length !== 0 ) {
        var element = $('<div id="box'+name+'" class="box left"><img src="" alt="" usemap=""><div class="map"></div></div>');

        first.before(element);
        this.setPageAttributes(element.find('img'), page[0], false);
      };

			Issue.manageCommentsTextPopUp($prev);
      this.position--;
      this.pageTurns++;
    },

    processFirstPages: function() {
      var $boxes = $('.box');
      var that = this;

      $boxes.each(function(index) {
        var $pid = retrieveInt( $(this).attr('id') );
        var $box = $(this);
				var page = that.pages[$pid - 1];
				// Just to make sure if some master_position's are missing, we are still
				// getting the right page T.M.
				if (page.master_position != $pid)
				{
					page = that.pages.filter(function(obj) {
				   return obj.master_position == $pid
				 });
				 page = page[0];
				}
				if (page !== undefined)
				{
					var object = $box.find('img');
					that.setPageAttributes(object, page, (index == 0));
					setTitlePic(object);
				}
      });

      resizeImageMaps();
    },

    pageCount: function() {
      return this.pages.length;
    },

    endpoint: function() {
      var arr = location.hostname.split('.');
      var end = arr.slice(Math.max(arr.length - 2, 1)).join(".");

		  if (arr.includes('lvh'))
			  return 'http://api.lvh.me:3000'
      return 'http://api.' + end;
	  },

    setPageAttributes: function(object, response, first_page) {
      var $cache = $(object);
	  	if (first_page) {
	      $cache.attr('src', response.images.large).on("load", function() {
					Issue.animateOnboarding();
					resizeImageMaps();
				})
			}
			else {
      	$cache.attr('src', response.images.large);
			}
      $cache.attr('alt', response.article.friendly_id);
      $cache.attr('usemap', 'page' + response.id);
      $cache.attr('data-article', response.article.id);
      $cache.attr('data-article-param', response.article.friendly_id);
			$cache.attr('title', response.article.title);
      $cache.attr('title_pic', response.article.title_pic);
      $cache.attr('data-position', response.master_position);
      $cache.attr('data-media', response.article.media_count);
      $cache.attr('data-interstitial', response.meta.interstitial);

      $cache.siblings('div.map').attr('name', 'page' + response.id);

      this.setImageMaps($cache.siblings('div.map'), response.meta.hyperlinks);
      this.setArticleContent(object, response.meta.content);
      this.setArticleLinks(response.article.id);
    },

    setBrowserTitle: function(object) {
      var href = window.location.href.split("/")
      var relative_url = "/" + href[3] + "/" + $(object).attr('alt');
      if (relative_url != location.pathname) {
        window.history.pushState('', 'Title', relative_url);
        document.title = 'The Shift Drink :: ' + $(object).attr('title');
        scrollToNavItem();
        setTitlePic(object);
      }
    },

		positionArrows: function(object, nav_is_opening, comments_opening) {
		  var margin = (window.innerWidth - object.width) / 2 + 10;
			var extras = (nav_is_opening ? navOffset() : (comments_opening ? commentsOffset() : 0));
      TweenLite.to(".arrow.next", options.tweenSpeed, {ease: Power0.easeNone, "margin-right": margin - extras + "px"});
      TweenLite.to(".arrow.prev", options.tweenSpeed, {ease: Power0.easeNone, "margin-left": margin + extras + "px"});
			if (!mobile)
        TweenLite.to(".subs_free.prev", options.tweenSpeed, {ease: Power0.easeNone, "margin-right": margin - extras - 73 + "px"});
		},

    setImageMaps: function(object, maps) {
	    $.each(maps, function(idx, data) {
				obj = $('<a></a>')
					.addClass("hyperlink")
					.attr({
						target:					"_blank",
						href:						data.source_url,
						"data-width":		data.coord_w,
						"data-height":	data.coord_h,
						"data-top":			data.coord_y,
						"data-left":		data.coord_x
					})
        object.append(obj)
      });
    },

    setArticleContent: function(object, content) {
      var identity = $(object).parent('.box').attr('id');
      this.articleContents[identity] = content;
    },

    setArticleLinks: function(article_id) {
      $('#article_id').val( article_id );
    },

    checkVisibility: function(total_pages) {
      if ( Issue.position > 1 ) {
        Issue.prevBtn.visible();
      } else {
        Issue.prevBtn.invisible();
      };

      if ( Issue.position < total_pages ) {
        Issue.nextBtn.visible();
      } else {
        Issue.nextBtn.invisible();
      };
    },

    getArticleLink: function(article) {
      var parts = window.location.href.split("/").filter(Boolean);
      var ending = parts[parts.length - 1];

      parts.shift();

      if ( $.inArray(ending, ['preview', 'm-issue', 'm-archives', 'issue', 'archives']) == -1 ) {
        parts.pop();
      };

      var article_link = 'http://' + parts.join("/");

      return article_link + '/' + article.friendly_id;
    },

    setShareContent: function() {
      var $pid = retrieveInt( $('.center').attr('id') );

      var page = this.pages.filter(function(obj) {
        return obj.master_position == $pid
      })[0];

      var cover = this.pages.filter(function(obj) {
        return obj.position_in_article == 1 && obj.article.id == page.article.id;
      })[0];

      var url = this.getArticleLink(page.article);

      $('.btn-twitter').attr('href', 'https://twitter.com/share?text=Check out this article from The Shift Drink: &url=' + url);


      $('meta[property="og:url"]').attr('content', url);
      $('meta[property="og:title"]').attr('content', page.article.title);
      $('meta[property="og:image"]').attr('content', cover.images.social);
      $('meta[property="og:description"]').attr('content', page.article.description);

      $('.btn-facebook').off(); // remove previous observer event
      $('.btn-facebook').on('click', function() {
        FB.ui({ method: 'share', href: url });
      });
    },

    triggerInterstitial: function() {
      $('#refresh-interstitial > a').click();

      $('.interstitial').fadeIn("slow", function() {
        $('.interstitial-container .ad-butler, .close-interstitial').show();
      });
    },
  };

  /* -----------------------------------------*
   *               IMPLEMENTATION             *
   * -----------------------------------------*/

   $('.comments-tab .fa-times').on('click', function(ev) {
	   ev.preventDefault();
	   closeCommentsTextTab();
   });

	 $('.comments-tab').on('click', function(ev) {
     if (ev.target.classList[0] == 'exit')
     {
       return;
     }
     $('#toggle-comments > a').click();
	 });

   $(document).keydown(function(e) {
	   if (e.which == 37) // Left arrow key
		   previousPage();
	   else if (e.which == 39) // Right arrow key
		   nextPage();
   });

  var position = $('#position').val();
  var issue_id = $('#issue_id').val();

  if ( position != undefined && issue_id != undefined ) {

    var time = new Date().getTime();

    var url  = window.location.href;
    var total = undefined;

    /**
     *
     * Make initial request for pages...
     *
     */
    $.ajax({ url: Issue.endpoint() + '/v1/issues/'+issue_id+'/pages' })
		.done(function(response) {
      var issue = Issue.init(issue_id, position, response);
      total = issue.pageCount();
      Issue.setShareContent();
      if ( position <= 1 )     Issue.prevBtn.invisible();
      if ( position == total ) Issue.nextBtn.invisible();
    });

    /**
     * Moves to next page (via swipe or click)
     * @return nothing
     */

    // callback function...
    function nextPage() {
      if ( Issue.position < total ) {

        var current = new Date().getTime();

        if ( typeof ga === 'function' ) {
          ga('send', {
            hitType: 'timing',
            timingCategory: 'Time on Page',
            timingVar: 'load',
            timingValue: time - current,
            timingLabel: '/virtual' + location.pathname
          });
        };

        time = current;

        Issue.nextPage();
        Issue.checkVisibility(total);
        Issue.setBrowserTitle('.center > img');
        Issue.setShareContent();

        if ( typeof ga === 'function' ) {
          ga('send', { hitType: 'pageview', page: '/virtual' + location.pathname });
          ga('send', {
            hitType       : 'event',
            eventCategory : 'Page Turn',
            eventAction   : 'turn',
            eventLabel    : '/virtual' + location.pathname
          });
        };
      };
      resizeImageMaps();
			refreshAd();
    };

    // via click...
    Issue.nextBtn.on('click', nextPage);

    // via swipe...
    $(document).on('swipeleft', 'body', nextPage);

    /**
     * Moves to previous page (via swipe or click)
     * @return nothing
     */

    // callback function...
    function previousPage() {
      if ( Issue.position > 1 ) {

        var current = new Date().getTime();

        if ( typeof ga === 'function' ) {
          ga('send', {
            hitType: 'timing',
            timingCategory: 'Time on Page',
            timingVar: 'load',
            timingValue: time - current,
            timingLabel: '/virtual' + location.pathname
          });
        };

        time = current;

        Issue.previousPage();
        Issue.checkVisibility(total);
        Issue.setBrowserTitle('.center > img');
        Issue.setShareContent();

        if ( typeof ga === 'function' ) {
          ga('send', { hitType: 'pageview', page: '/virtual' + location.pathname });
          ga('send', {
            hitType       : 'event',
            eventCategory : 'Page Turn',
            eventAction   : 'turn',
            eventLabel    : '/virtual' + location.pathname
          });
        };
      };

      resizeImageMaps();
			refreshAd();
    };

    // via click
    Issue.prevBtn.on('click', previousPage);

    // via swipe...
    $(document).on('swiperight', 'body', previousPage);
  };

	function refreshAd() {
		var random = Math.floor(Math.random() * 4) + 1;

		if ( mobile === true ) {
			if ( random > 1 ) return false;
		};

		if (Issue.pageTurns % 4 == 0)
		{
			if ($('.ad-skyscraper').is(":visible") || ($('.ad-skyscraper2').is(":visible")))
			{
				$('.ad-skyscraper').toggle();
				$('.ad-skyscraper2').toggle();
			}
			else if ($('.ad-mobile').is(":visible") || ($('.ad-mobile2').is(":visible"))) {
					if ($('.ad-mobile').is(":visible"))
					{
						$(".ad-mobile").css("display", "none");
						$(".ad-mobile2").css("display", "flex");
					}
					else {
						$(".ad-mobile2").css("display", "none");
						$(".ad-mobile").css("display", "flex");
					}
			}
		}
		else if ((Issue.pageTurns + 2) % 4 == 0)
			$('#refresh-ad > a').click();
	};

  /* -----------------------------------------*
   *             TOGGLE THUMBNAILS            *
   * -----------------------------------------*/

	function navOffset() {
		return ((250 - $("#main-advertisements").width())/2);
	}

	function commentsOffset() {
		return ((510 - $("#main-advertisements").width())/2);
	};

  function totalOffset(box) {
    var offset = 0;
    if (navIsOpen())
      offset = navOffset();
    else if (commentsOpen())
      offset = commentsOffset();
    return (offset);
  }

	function navIsOpen() {
		return ($('#wrapper').offset().left > -250);
	};

	function commentsOpen() {
    return ($('#comments').offset().left > -510);
	};

	function scrollToNavItem() {
		var nav_item = $.grep($("#wrapper .menu-item"), function(n, i) {
			return ($(n).find("a").attr("href") == location.pathname);
		});
		if ($(nav_item).offset() != undefined)
			$("#wrapper").animate({scrollTop: $("#wrapper").scrollTop() + $(nav_item).offset().top}, options.page_speed);
	}

	function openNav() {
		// Opening the nav
		$(".fa-bars").addClass("active");
    TweenLite.to("#wrapper", options.tweenSpeed, {ease: Power0.easeNone, "-webkit-transform": "translateX(250px)"});
		if (!mobile)
    {
      TweenLite.to(".box.center", options.tweenSpeed, {ease: Power0.easeNone, "-webkit-transform": "translateX(-" + ($(window).width() - navOffset()) + "px)"});
    }
		Issue.positionArrows($(".box").first().find("img")[0], true, false);
		scrollToNavItem();
	}

	function closeNav() {
		// Closing the nav
		$(".fa-bars").removeClass("active");
    TweenLite.to("#wrapper", options.tweenSpeed, {ease: Power0.easeNone, "-webkit-transform": "translateX(0)"});
		if (!mobile)
		{
      TweenLite.to(".box.center", options.tweenSpeed, {ease: Power0.easeNone, "-webkit-transform": "translateX(-" + $(window).width() + "px)"});
		}
		Issue.positionArrows($(".box").first().find("img")[0], false, false);
		$("#wrapper").animate({scrollTop: -3000}, options.page_speed);
	}

	function triggerNav() {
		if (commentsOpen())
			triggerComments();
		navIsOpen() ? closeNav() : openNav();
	};

	function openComments() {
    TweenLite.to("#comments", options.tweenSpeed, {ease: Power0.easeNone, "-webkit-transform": "translateX(500px)"});
		if (!mobile) {
      TweenLite.to(".box.center", options.tweenSpeed, {ease: Power0.easeNone, "-webkit-transform": "translateX(-" + ($(window).width() - commentsOffset()) + "px)"});
		}
    closeCommentsTextTab();
		$(".fa-comments").addClass("active");
		Issue.positionArrows($(".box").first().find("img")[0], false, true);
	}

	function closeComments() {
    TweenLite.to("#comments", options.tweenSpeed, {ease: Power0.easeNone, "-webkit-transform": "translateX(0)"});
		if (!mobile)
		{
      TweenLite.to(".box.center", options.tweenSpeed, {ease: Power0.easeNone, "-webkit-transform": "translateX(-" + $(window).width() + "px)"});
		}
		$(".fa-comments").removeClass("active");
		Issue.positionArrows($(".box").first().find("img")[0], false, false);
	}

	function triggerComments() {
		if (navIsOpen())
			closeNav();
		commentsOpen() ? closeComments() : openComments();
	}

	function openBottomBar() {
    TweenLite.to("#bottom-bar", options.tweenSpeed, {"-webkit-transform": "translateY(-70px)"});
	};

	function setCommentsLink() {
		var name = retrieveInt($(".box.center").attr('id'));
		var page = Issue.pages.filter(function(obj) {
			return obj.master_position == name
		});
		$('#toggle-comments > a').attr('href', '/comments?article_id=' + page[0].article.id);
	};

  $('#toggle-thumbs').on('taphold click', function(e) {
    e.preventDefault();
    triggerNav();
  });

	$('#toggle-comments').on('taphold click', function(e) {
    e.preventDefault();

    setCommentsLink();
    triggerComments()
  });

  $('#scroll-content a').on('taphold click vclick', function(e) {
    e.preventDefault();

    window.location.href = $(this).attr('href');
  })

	/* -----------------------------------------*
   *               RESIZING CALLBACKS         *
   * -----------------------------------------*/

	var rtime;
	var timeout = false;
	var delta = 200;
	$(window).resize(function() {
    rtime = new Date();
    if (timeout === false) {
      timeout = true;
      setTimeout(resizeend, delta);
    }
	});

	function resizeend() {
    if (new Date() - rtime < delta) {
      setTimeout(resizeend, delta);
    } else {
      timeout = false;
			resizeImageMaps();
 	   	Issue.positionArrows($(".box").first().find("img")[0], navIsOpen(), commentsOpen());
    }
    TweenLite.to(".box.center", options.tweenSpeed, {ease: Power0.easeNone, "-webkit-transform": "translateX(" + (parseInt($(".box.center").css("transform").split(",")[4]) + totalOffset() - $(".box.center").position().left) + "px)"});
		var freeSpace = $(window).width() - $(".box.center img").width()
		if  (navIsOpen() &&
					((freeSpace - ($(".ad-wrapper").css("display") != "none" ? $(".ad-wrapper").width() : (0)
					) * 2) < 100)
				)
		{
			closeNav();
		}
		else if (!navIsOpen() && freeSpace / 2 <= 180)
			$(".ad-wrapper").css('display', 'none');
		else if (freeSpace / 2 > 180)
			$(".ad-wrapper").css('display', 'flex');
	}

  $(document).on('taphold click', '.hyperlink', function() {
    window.open($(this).attr('href'));
    return false;
  });
});
