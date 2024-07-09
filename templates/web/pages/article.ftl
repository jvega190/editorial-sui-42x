<#import "/templates/system/common/crafter.ftl" as crafter />

<!DOCTYPE HTML>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html lang="en">
<head>
	<#include "/templates/web/fragments/head.ftl">
	<@crafter.head/>
</head>
<body>
<@crafter.body_top/>

<!-- Wrapper -->
<div id="wrapper">
	<!-- Main -->
	<div id="main">
		<div class="inner">

			<!-- Header -->
			<@renderComponent component = contentModel.header_o.item />

			<!-- Content -->
			<section>
				<header class="main">
          <@crafter.h1 $field="subject_t">
            ${contentModel.subject_t!""}
          </@crafter.h1>
          <div>
            by <@crafter.span $field"author_s">${contentModel.author_s!""}</@crafter.span>
          </div>
				</header>
				<#if contentModel.image_s??>
					<#assign image = contentModel.image_s/>
				<#else>
					<#assign image = "/static-assets/images/placeholder.png"/>
				</#if>
				<span class="image main">
          <@crafter.img $field='image_s' src="${image}" alt=""/>
        </span>

        <@crafter.renderRepeatGroup
          $field="sections_o"
          $containerAttributes={'style': 'list-style: none; padding-left: 0;'};
          item, index
        >
          <@crafter.div
            $field="sections_o.section_html"
            $index=index
          >
            ${item.section_html}
          </@crafter.div>
          <hr class="major" />
        </@crafter.renderRepeatGroup>
			</section>
		</div>
	</div>

	<#assign articleCategories = contentModel.queryValues("//categories_o/item/key")/>
	<#assign articlePath = contentModel.storeUrl />
	<#assign additionalModel = {"articleCategories": articleCategories, "articlePath": articlePath }/>

	<!-- Left Rail -->
	<@renderComponent component = contentModel.left_rail_o.item additionalModel = additionalModel />

</div>

<#include "/templates/web/fragments/scripts.ftl">

<script>
    var crafterSocial_cfg = {
        'comments.acceptTerms'          : false, // if user has to accept terms before posting or replying comment
        'url.service': 'http://localhost:8080/crafter-social/api/3/',
        'url.security.value': 'http://localhost:8080/crafter-social/crafter-security-login',
        'url.security.active': 'http://localhost:8080/crafter-social/crafter-security-current-auth',
        'url.base': '/static-assets/sui2/alt/',
        'url.templates': '/static-assets/sui2/alt/templates/'
    };

    function crafterSocial_onAppReady ( director, CrafterSocial ) {
        window.CKEDITOR.plugins.basePath = '/static-assets/sui/libs/ckeditor/plugins/';

        CrafterSocial.$.extend(CrafterSocial.string.LOCALE, {
            'commentable.view-comment': 'View & Comment',
            'commentable.notify-comment': 'Notify on Reply',
            'popover.no-comment': '(no comments)',
            'discussion.title': 'Discussion',
            'discussion.comment': 'Be the first to comment!',
            'discussion.login-comment': '',
            'options.options': 'Options',
            'options.inline': 'Inline View',
            'options.lightbox': 'Lightbox View',
            'options.bubble': 'Bubble View',
            'options.refresh': 'Refresh',
            'options.close': 'Close',
            'commenting.submissionLabel': 'Your submission will not appear until approved by the blog admin.',
            'commenting.agreeTermsLabel': 'I have read and agree to Terms of Use of this blog',
            'commenting.agreeTermsLinkText': 'LINK HERE',
            'commenting.agreeTermsLink': '#',
            'comments.flag': 'Report',
            'commenting.attachmentsTip': 'Adding photos? Post your comment then add them to your post.'
        });

    }
</script>

<script src="/static-assets/sui2/alt/scripts/social.js"></script>

<script>
    $.ajax({
        method: "POST",
        url: "http://localhost:8080/crafter-social/crafter-security-login",
        data: {username: "admin", password: "admin"}
    })
        .done(function (msg) {
            // alert( "login successful" );
        });
</script>

<script>
    crafter.social.getDirector().on(crafter.social.Constants.get('EVENT_USER_AUTHENTICATION_SUCCESS'), function
        (profile) {
        var director = crafter.social.getDirector();

        director.socialise({
            target: '#${contentModel.objectId}',
            context: 'f5b143c2-f1c0-4a10-b56e-f485f00d3fe9',
            view: {
                'parasite': {
                    'cfg': {
                        'discussionView': 'view.Inline'
                    }
                }
            }
        });
    });
</script>


<@crafter.body_bottom/>
</body>
</html>
