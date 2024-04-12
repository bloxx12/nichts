{
    config,
    lib,
    pkgs,
    ...
}: with lib; let 
    cfg = config.modules.programs.vesktop;
    username = config.modules.other.system.username;
in {
    options.modules.programs.vesktop = {
        enable = mkEnableOption "vesktop";
    };

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            xdg.configFile."vesktop/settings.json".text = builtins.toJSON {
                discordBranch = "ptb";
                firstLaunch = false;
                arRPC = "on";
                splashColor = "rgb(219, 222, 225)";
                splashBackground = "rgb(49, 51, 56)";
                checkUpdates = false;
                staticTitle = true;
                disableMinSize = true;
                minimizeToTray = false;
                tray = false;
                appBadge = false;
            };

            xdg.configFile."vesktop/settings/settings.json".text = builtins.toJSON {
                notifyAboutUpdates = false;
                autoUpdate = false;
                autoUpdateNotification = false;
                useQuickCss = true;
                themeLinks = [];
                enabledThemes = ["Catppuccin.theme.css"];
                enableReactDevtools = true;
                frameless = false;
                transparent = false;
                winCtrlQ = false;
                macosTranslucency = false;
                disableMinSize = true;
                winNativeTitleBar = false;
                plugins = {
                    BadgeAPI.enabled = true;
                    CommandsAPI.enabled = true;
                    ContextMenuAPI.enabled = true;
                    MemberListDecoratorsAPI.enabled = true;
                    MessageAccessoriesAPI.enabled = true;
                    MessageDecorationsAPI.enabled = true;
                    MessageEventsAPI.enabled = true;
                    MessagePopoverAPI.enabled = true;
                    NoticesAPI.enabled = true;
                    ServerListAPI.enabled = true;
                    SettingsStoreAPI.enabled = true;
                    NoTrack.enabled = true;
                    Settings = {
                        enabled = true;
                        settingsLocation = "aboveActivity";
                    };
                    AlwaysAnimate.enabled = false;
                    AlwaysTrust.enabled = false;
                    AnonymiseFileNames.enabled = false;
                    "WebRichPresence (arRPC)".enabled = false;
                    BANger.enabled = false;
                    BetterFolders = {
                        enabled = true;
                        sidebar = true;
                        sidebarAnim = true;
                        closeAllFolders = false;
                        closeAllHomeButton = false;
                        closeOthers = false;
                        forceOpen = false;
                        keepIcons = false;
                        showFolderIcon = 1;
                    };
                    BetterGifAltText.enabled = false;
                    BetterNotesBox.enabled = false;
                    BetterRoleDot.enabled = false;
                    BetterUploadButton.enabled = true;
                    BiggerStreamPreview.enabled = true;
                    BlurNSFW.enabled = false;
                    CallTimer = {
                        enabled = true;
                        format = "human";
                    };
                    ClearURLs.enabled = true;
                    ColorSighted.enabled = true;
                    ConsoleShortcuts.enabled = false;
                    CopyUserURLs.enabled = true;
                    CrashHandler.enabled = true;
                    CustomRPC.enabled = false;
                    Dearrow.enabled = true;
                    DisableDMCallIdle.enabled = true;
                    EmoteCloner.enabled = false;
                    Experiments = {
                        enabled = true;
                        enableIsStaff = false;
                    };
                    F8Break.enabled = false;
                    FakeNitro = {
                        enabled = true;
                        enableEmojiBypass = true;
                        emojiSize = 48;
                        transformEmojis = true;
                        enableStickerBypass = true;
                        stickerSize = 160;
                        transformStickers = true;
                        transformCompoundSentence = false;
                        enableStreamQualityBypass = true;
                    };
                    FakeProfileThemes = {
                        enabled = true;
                        nitroFirst = true;
                    };
                    FavoriteEmojiFirst.enabled = true;
                    FavoriteGifSearch = {
                        enabled = true;
                        searchOption = "hostandpath";
                    };
                    FixImagesQuality.enabled = true;
                    FixSpotifyEmbed = {
                        enabled = true;
                        volume = 10;
                    };
                    ForceOwnerCrown.enabled = true;
                    FriendInvites.enabled = false;
                    GameActivityToggle.enabled = true;
                    GifPaste.enabled = true;
                    HideAttachments.enabled = true;
                    iLoveSpam.enabled = true;
                    IgnoreActivities = {
                        enabled = true;
                        ignoredActivities = [];
                    };
                    ImageZoom = {
                        enabled = true;
                        saveZoomValues = true;
                        invertScroll = true;
                        nearestNeighbour = false;
                        square = false;
                        zoom = 2;
                        size = 100;
                        zoomSpeed = 0.5;
                    };
                    InvisibleChat = {
                        enabled = true;
                        savedPasswords = "password";
                    };
                    KeepCurrentChannel.enabled = true;
                    LastFMRichPresence.enabled = false;
                    LoadingQuotes.enabled = false;
                    MemberCount.enabled = true;
                    MessageClickActions = {
                        enabled = true;
                        enableDeleteOnClick = true;
                        enableDoubleClickToEdit = true;
                        enableDoubeClickToReply = true;
                        requireModifier = true;
                    };
                    MessageLinkEmbeds = {
                        enabled = true;
                        automodEmbeds = "never";
                        listMode = "blacklist";
                        idList = "";
                    };
                    MessageLogger = {
                        enabled = true;
                        deleteStyle = "text";
                        ignoreBots = false;
                        ignoreSelf = false;
                        ignoreUsers = "";
                        ignoreChannels = "";
                        ignoreGuilds = "";
                    };
                    MessageTags.enabled = false;
                    MoreCommands.enabled = true;
                    MoreKaomoji.enabled = true;
                    MoreUserTags.enabled = true;
                    Moyai.enabled = false;
                    MuteNewGuild = {
                        enabled = true;
                        guild = false;
                        everyone = true;
                        role = true;
                    };
                    MutualGroupDMs.enabled = true;
                    NoBlockedMessages = {
                        enabled = false;
                        ignoreBlockedMessages = false;
                    };
                    NoDevtoolsWarning.enabled = false;
                    NoF1.enabled = false;
                    NoPendingCount.enabled = false;
                    NoProfileThemes.enabled = true;
                    NoReplyMention = {
                        enabled = true;
                        userList = "372809091208445953";
                        shouldPingListed = false;
                        inverseShiftReply = true;
                    };
                    NoScreensharePreview.enabled = true;
                    NoTypingAnimation = true;
                    NoUnblockToJump.enabled = true;
                    NSFWGateBypass.enabled = true;
                    oneko.enabled = false;
                    OpenInApp.enabled = false;
                    "Party mode 🎉".enabled = false;
                    PermissionFreeWill = {
                        enabled = true;
                        lockout = true;
                        onboarding = true;
                    };
                    PermissionsViewer = {
                        enabled = true;
                        permissionsSortOrder = 0;
                        defaultPermissionsDropdownState = false;
                    };
                    petpet.enabled = true;
                    PictureInPicture = {
                        enabled = true;
                        loop = false;
                    };
                    PinDMs.enabled = true;
                    PlainFolderIcon.enabled = false;
                    PlatformIndicators = {
                        enabled = true;
                        list = true;
                        badges = true;
                        messages = true;
                        colorMobileIndicator = true;
                    };
                    PreviewMessage.enabled = true;
                    PronounDB.enabled = false;
                    QuickMention.enabled = false;
                    QuickReply.enabled = false;
                    ReactErrorDecoder.enabled = false;
                    ReadAllNotificationsButton.enabled = false;
                    RelationshipNotifier = {
                        enabled = true;
                        notices = true;
                        offlineRemovals = true;
                        friends = true;
                        friendRequestCancels = true;
                        servers = true;
                        groups = true;
                    };
                    RevealAllSpoilers.enabled = true;
                    ReverseImageSearch.enabled = false;
                    ReviewDB.enabled = false;
                    RoleColorEverywhere = {
                        enabled = true;
                        chatMentions = true;
                        memberList = true;
                        voiceUsers = true;
                    };
                    SearchReply.enabled = true;
                    SendTimestamps.enabled = false;
                    ServerListIndicators = {
                        enabled = true;
                        mode = 3;
                    };
                    ServerProfile.enabled = true;
                    ShikiCodeblocks = {
                        enabled = true;
                        theme = "https://raw.githubusercontent.com/shikijs/shiki/0b28ad8ccfbf2615f2d9d38ea8255416b8ac3043/packages/shiki/themes/dark-plus.json";
                        tryHljs = "SECONDARY";
                        uesDevIcon = "GREYSCALE";
                        bgOpacity = 100;
                    };
                    ShowAllMessageButtons.enabled = true;
                    ShowConnections = {
                        enabled = true;
                        iconSize = 32;
                        iconSpacing = 1;
                    };
                    ShowHiddenChannels = {
                        enabled = true;
                        hideUnreads = true;
                        showMode = 0;
                        defaultAllowedUsersAndRolesDropdownState = true;
                    };
                    ShowMeYourName.enabled = false;
                    ShowTimeouts.enabled = true;
                    SilentMessageToggle = {
                        enabled = true;
                        persistState = false;
                        autoDisable = true;
                    };
                    SilentTyping = {
                        enabled = true;
                        showIcon = false;
                        isEnabled = true;
                    };
                    SortFriendRequests.enabled = false;
                    SpotifyControls.enabled = false;
                    SpotifyCrack.enabled = false;
                    SpotifyShareCommands.enabled = false;
                    StartupTimings.enabled = false;
                    SupportHelper.enabled = true;
                    TextReplace.enabled = false;
                    TimeBarAllActivities.enabled = false;
                    Translate.enabled = false;
                    TypingIndicator = {
                        enabled = true;
                        includeMutedChannels = false;
                        includeBlockedUsers = true;
                    };
                    TypingTweaks = {
                        enabled = true;
                        showAvatars = true;
                        showRoleColors = true;
                        alternativeFormatting = true;
                    };
                    Unindent.enabled = true;
                    UnsuppressEmbeds.enabled = true;
                    UrbanDictionary.enabled = false;
                    UserVoiceShow = {
                        enabled = true;
                        showInUserProfileModal = true;
                        showVoiceChannelSectionHeader = true;
                    };
                    USRBG.enabled = false;
                    UwUifier.enabled = false;
                    ValidUser.enabled = false;
                    VoiceChatDoubleClick.enabled = true;
                    VcNarrator.enabled = false;
                    VencordToolbox.enabled = false;
                    ViewIcons = {
                        enabled = true;
                        format = "png";
                        imgSize = "2048";
                    };
                    ViewRaw = {
                        enabled = true;
                        clickMethod = "Left";
                    };
                    VoiceMessages = {
                        enabled = true;
                        noiseSuppression = true;
                        echoCancellation = true;
                    };
                    WebContextMenus = {
                        enabled = true;
                        addBack = true;
                    };
                    WebKeybinds.enabled = true;
                    GreetStickerPicker.enabled = false;
                    WhoReacted.enabled = true;
                    Wikisearch.enabled = false;
                    NormalizeMessageLinks.enabled = false;
                    "AI Noise Suppression" = {
                        enabled = true;
                        isEnabled = true;
                    };
                    SecretRingToneEnabler.enabled = false;
                };
                notifications = {
                    timeout = 5000;
                    position = "bottom-right";
                    useNative = "not-focused";
                    logLimit = 50;
                };
                cloud = {
                    authenticated = false;
                    url = "https://api.vencord.dev/";
                    settingsSync = false;
                    settingsSyncVersion = 1682768329526;
                };
            };
        };
    };
}
