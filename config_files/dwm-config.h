
/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]            = "-*-terminus-medium-r-*-*-16-*-*-*-*-*-*-*";
static const char normbordercolor[] = "black";
static const char normbgcolor[]     = "black";
static const char normfgcolor[]     = "gray";
static const char selbordercolor[]  = "black";
static const char selbgcolor[]      = "black";
static const char selfgcolor[]      = "white";
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = False;    /* False means bottom bar */

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* class       instance    title       tags mask     isfloating   monitor */
	{ "Grpn",      NULL,       NULL,       0,            True,        -1 },
	{ "XTerm",     "xterm",    "orpie",    0,            True,        -1 },
	{ "Gimp",      NULL,       NULL,       0,            True,        -1 },
	{ "Stopwatch", NULL,       NULL,       0,            True,        -1 },
	{ "Firefox",   NULL,       NULL,       1 << 8,       False,       -1 },
};

/* layout(s) */
static const float mfact      = 0.618; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = True; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define altMODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "xterm", "tmux", NULL };
static const char *webcmd[]   = { "dwb", NULL };
static const char *firefoxcmd[]   = { "firefox", NULL };
static const char *filescmd[]  = { "pcmanfm", NULL };
static const char *xkillcmd[]  = { "xkill", NULL };
static const char *editcmd[]  = { "leafpad", NULL };
static const char *calcmd[]  = { "xterm", "-geometry", "44x25", "orpie", NULL };
static const char *slovene[]  = { "/home/jk/.prog/keyboard.sh", "si", NULL };
static const char *russian[]  = { "/home/jk/.prog/keyboard.sh", "ru", NULL };
static const char *greek[]  = { "/home/jk/.prog/keyboard.sh", "gr", NULL };
static const char *english[]  = { "/home/jk/.prog/keyboard.sh", "us", NULL };
//static const char *okularcmd[]  = { "okular", "/home/jk/books/physics/RHB.pdf", NULL };
static const char *chromiumcmd[]  = { "/usr/bin/google-chrome", NULL };
static const char *kMplayercmd[]  = { "killall", "mplayer", NULL };
static const char *koctavecmd[]  = { "killall", "mplayer", NULL };
static const char *amcmd[]  = { "xterm", "-e", "alsamixer -c 0", NULL };
static const char *mailcmd[]  = { "xterm", "mutt", NULL };
static const char *nullcmd[]  = { NULL };
static const char *vup[]  = { "amixer", "--", "set", "Master", "1%+", NULL };
static const char *vdown[]  = { "amixer", "--", "set", "Master", "1%-", NULL };
static const char *mute[]  = { "amixer", "--", "set", "Master", "toggle", NULL };
static const char *v1[]  = { "amixer", "set", "Master", "0%", NULL };
static const char *v2[]  = { "amixer", "set", "Master", "10%", NULL };
static const char *v3[]  = { "amixer", "set", "Master", "20%", NULL };
static const char *v4[]  = { "amixer", "set", "Master", "30%", NULL };
static const char *v5[]  = { "amixer", "set", "Master", "40%", NULL };
static const char *v6[]  = { "amixer", "set", "Master", "50%", NULL };
static const char *v7[]  = { "amixer", "set", "Master", "60%", NULL };
static const char *v8[]  = { "amixer", "set", "Master", "70%", NULL };
static const char *v9[]  = { "amixer", "set", "Master", "80%", NULL };
static const char *slockcmd[]  = { "slock", NULL };
static const char *ebaycmd[]  = { "/home/jk/.prog/ebay.sh", NULL };
//static const char *gnumericcmd[]  = { "/usr/bin/gnumeric", NULL };
static const char *gnumericcmd[]  = { "/home/jk/.prog/gnumeric/bin/gnumeric", NULL };
static const char *sscmd[]  = { "sh", "/home/jk/.prog/ss.sh", NULL };
static const char *kcmd[]  = { "sh", "/home/jk/.prog/k.sh", NULL };
static const char *dayscmd[]  = { "sh", "/home/jk/.prog/days.sh", NULL };
static const char *ankicmd[]  = { "anki", "-b/home/jk/.anki", NULL };
static const char *stopwatchcmd[]  = { "stopwatch", NULL };
static const char *invertcmd[]  = { "xcalib", "-i", "-a", NULL };
static const char *linkopencmd[]  = { "bash", "/home/jk/.prog/link-opener.sh", NULL };
static const char *black[]  = { "xbacklight", "-set", "0", NULL };
static const char *dark[]  = { "xbacklight", "-set", "1", NULL };
static const char *bright[]  = { "xbacklight", "-set", "50", NULL };
static const char *superbright[]  = { "xbacklight", "-set", "100", NULL };
static const char *brighter[]  = { "xbacklight", "-inc", "5", NULL };
static const char *darker[]  = { "xbacklight", "-dec", "5", NULL };
static const char *shootcmd[]  = { "sh", "/home/jk/.prog/shoot.sh", NULL };
static const char *musiccmd[]  = { "/home/jk/.prog/deadbeef-0.7.2/deadbeef", NULL };
static const char *passcmd[]  = { "/usr/bin/keepassx", NULL };
//static const char *recordmacro[]  = { "sh", "/home/jk/.prog/recordmacro.sh", NULL };
//static const char *playmacro[]  = { "sh", "/home/jk/.prog/playmacro.sh", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY|ShiftMask,             XK_F1,     spawn,          {.v = v1 } },
	{ MODKEY|ShiftMask,             XK_F2,     spawn,          {.v = v2 } },
	{ MODKEY|ShiftMask,             XK_F3,     spawn,          {.v = v3 } },
	{ MODKEY|ShiftMask,             XK_F4,     spawn,          {.v = v4 } },
	{ MODKEY|ShiftMask,             XK_F5,     spawn,          {.v = v5 } },
	{ MODKEY|ShiftMask,             XK_F6,     spawn,          {.v = v6 } },
	{ MODKEY|ShiftMask,             XK_F7,     spawn,          {.v = v7 } },
	{ MODKEY|ShiftMask,             XK_F8,     spawn,          {.v = v8 } },
	{ MODKEY|ShiftMask,             XK_F9,     spawn,          {.v = v9 } },
	{ MODKEY,                       XK_F1,     spawn,          {.v = slovene } },
	{ MODKEY,                       XK_F2,     spawn,          {.v = russian } },
	{ MODKEY,                       XK_F3,     spawn,          {.v = greek } },
	{ MODKEY,                       XK_F4,     spawn,          {.v = english } },
	{ MODKEY,                       XK_q,      spawn,          {.v = black } },
	{ MODKEY,                       XK_w,      spawn,          {.v = dark } },
	{ MODKEY,                       XK_e,      spawn,          {.v = linkopencmd } },
	{ MODKEY,                       XK_r,      spawn,          {.v = bright } },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_y,      spawn,          {.v = xkillcmd } },
	{ MODKEY,                       XK_u,      spawn,          {.v = mute } },
	{ MODKEY,                       XK_i,      spawn,          {.v = vdown } },
	{ MODKEY,                       XK_o,      spawn,          {.v = vup } },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_a,      spawn,          {.v = filescmd } },
	{ MODKEY,                       XK_s,      spawn,          {.v = superbright } },
	{ MODKEY,                       XK_d,      spawn,          {.v = darker } },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_g,      spawn,          {.v = brighter } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_j,      view,           {0} },
	{ MODKEY,                       XK_k,      spawn,          {.v = kcmd } },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_z,      spawn,          {.v = webcmd } },
	{ MODKEY,                       XK_x,      spawn,          {.v = mailcmd } },
	{ MODKEY,                       XK_c,      spawn,          {.v = shootcmd } },
	{ MODKEY,                       XK_v,      spawn,          {.v = nullcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	//{ MODKEY,                       XK_n,      setlayout,      {.v = &layouts[8]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	//{ MODKEY,                       XK_Down,   moveresize,     {.v = (int []){ 0, 25, 0, 0 }}},
	//{ MODKEY,                       XK_Up,     moveresize,     {.v = (int []){ 0, -25, 0, 0 }}},
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	//{ MODKEY,                       XK_Right,  moveresize,     {.v = (int []){ 25, 0, 0, 0 }}},
	//{ MODKEY,                       XK_Left,   moveresize,     {.v = (int []){ -25, 0, 0, 0 }}},
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ MODKEY|ShiftMask,             XK_w,      spawn,          {.v = nullcmd } },
	{ MODKEY|ShiftMask,             XK_e,      spawn,          {.v = ebaycmd } },
	{ MODKEY|ShiftMask,             XK_r,      spawn,          {.v = editcmd } },
	{ MODKEY|ShiftMask,             XK_t,      spawn,          {.v = koctavecmd } },
	{ MODKEY|ShiftMask,             XK_z,      spawn,          {.v = nullcmd } },
	{ MODKEY|ShiftMask,             XK_u,      spawn,          {.v = invertcmd } },
	{ MODKEY|ShiftMask,             XK_i,      spawn,          {.v = amcmd } },
	{ MODKEY|ShiftMask,             XK_o,      spawn,          {.v = chromiumcmd } },
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = passcmd } },
	{ MODKEY|ShiftMask,             XK_a,      spawn,          {.v = ankicmd } },
	{ MODKEY|ShiftMask,             XK_s,      spawn,          {.v = stopwatchcmd } },
	{ MODKEY|ShiftMask,             XK_d,      spawn,          {.v = dayscmd } },
	{ MODKEY|ShiftMask,             XK_f,      spawn,          {.v = firefoxcmd } },
	{ MODKEY|ShiftMask,             XK_g,      spawn,          {.v = nullcmd } },
	{ MODKEY|ShiftMask,             XK_z,      spawn,          {.v = nullcmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_x,      spawn,          {.v = calcmd } },
	{ MODKEY|ShiftMask,             XK_n,      spawn,          {.v = gnumericcmd } },
	//{ MODKEY|ShiftMask,             XK_h,      spawn,          {.v = haltcmd } },
	{ MODKEY|ShiftMask,             XK_j,      spawn,          {.v = sscmd } },
	{ MODKEY|ShiftMask,             XK_l,      spawn,          {.v = slockcmd } },
	{ MODKEY|ShiftMask,             XK_m,      spawn,          {.v = musiccmd } },
	{ MODKEY|ShiftMask,             XK_k,      spawn,          {.v = kMplayercmd } },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	//{ MODKEY|ShiftMask,             XK_Down,   moveresize,     {.v = (int []){ 0, 0, 0, 25 }}},
	//{ MODKEY|ShiftMask,             XK_Up,     moveresize,     {.v = (int []){ 0, 0, 0, -25 }}},
	//{ MODKEY|ShiftMask,             XK_Right,  moveresize,     {.v = (int []){ 0, 0, 25, 0 }}},
//	{ MODKEY|ShiftMask,             XK_Left,   moveresize,     {.v = (int []){ 0, 0, -25, 0 }}},
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ altMODKEY,                    XK_Tab,    focusstack,     {.i = +1 } },
	{ altMODKEY|ShiftMask,          XK_Tab,    focusstack,     {.i = -1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

