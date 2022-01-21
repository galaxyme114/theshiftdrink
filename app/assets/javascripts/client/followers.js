$(function() {
	var stage = Cookies.get('sd-followers-prompt-stage');
	var tmp_stage = null;
	function setCookie(stage) {
		Cookies.set('sd-followers-prompt-stage', stage, { expires: 999});
	};

	function openNextStage() {
		$('.followers .stage' + tmp_stage).css('display', 'none');
		stage++;
		setCookie(stage);
	}

	function clickCallback() {
		tmp_stage = stage;
		TweenLite.to(".followers", .25, {onUpdate: openNextStage, ease: Power0.easeNone, "-webkit-transform": "translateX(0)"});
		var promise = setInterval(function() {
			if (window.document.hasFocus() == true)
			{
				if (tmp_stage + 1 == 3 && $('.followers .stage3')[0] === undefined)
				{
					completeStages();
					return;
				}
				else {
					setTimeout(function() {
						$('.followers .stage' + stage).css('display', 'block');
						TweenLite.to(".followers", .25, {ease: Power0.easeNone, "-webkit-transform": "translateX(-450px)"});
					}, 1000);
					clearInterval(promise)
				}
			}
		}, 500);
	};

	function completeStages() {
		TweenLite.to(".followers", .25, {ease: Power0.easeNone, "-webkit-transform": "translateX(0)"});
		setCookie(4);
	};

	function frameClickCallback() {
		setTimeout(function() {
			clickCallback();
		}, 100);
	};

	if (stage === undefined)
	{
		Cookies.set('sd-followers-prompt-stage', 1, { expires: 999});
		stage = 1;
	}
	stage = parseInt(stage);
	setTimeout(function() {
		$('.followers iframe').iframeTracker({
			blurCallback: function(event){
				frameClickCallback();
			}
		});
		$('.followers .stage2 a').on('click', function() {
			frameClickCallback();
		})
		$('.followers .btn-social-login').on('click', function() {
			completeStages();
		});
	}, 5000);

	$('.close-followers-prompt .fa-times').on('click', function() {
		completeStages();
	});


});
