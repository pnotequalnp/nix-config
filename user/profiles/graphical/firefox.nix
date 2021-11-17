addons:

{
  enable = true;
  extensions = with addons; [
    bitwarden
    clearurls
    darkreader
    facebook-container
    honey
    https-everywhere
    i-dont-care-about-cookies
    multi-account-containers
    react-devtools
    stylus
    ublock-origin
    vimium
  ];

  profiles.kevin = {
    settings = {
      "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      "browser.newtabpage.activity-stream.feeds.snippets" = false;
      "browser.newtabpage.activity-stream.feeds.topsites" = false;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.uidensity" = 1;
      "devtools.theme" = "dark";
      "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "browser.tabs.opentabfor.middleclick" = false;
      "browser.link.open_newwindow" = 2;
    };

    userChrome = ''
      #TabsToolbar {
        display: none !important;
      }
    '';
  };
}
