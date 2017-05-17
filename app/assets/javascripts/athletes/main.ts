/// <reference path="./../typings/hubspot-pace.d.ts" />
/// <reference path="./../typings/jquery.d.ts" />
/// <reference path="./../typings/toastr.d.ts" />
/// <reference path="./../common/helpers.ts" />

Pace.on('hide', () => {
    $('body').removeClass('page-loading').addClass('page-loaded');
});

$(document).ready(() => {
    toastr.options = Toastr.getOptions();

    GoogleAnalytics.bindEvents().apply(null);
    EventBinders.bindAll().apply(null);

    const overview = new Views.Overview();
    overview.createNavigationItems();
    overview.load();
});
