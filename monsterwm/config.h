/* see LICENSE for copyright and license */
/* modified by Uros Stegic */

#ifndef CONFIG_H
#define CONFIG_H

/** modifiers **/
#define MOD1            Mod1Mask    /* ALT key */
#define MOD4            Mod4Mask    /* Super/Windows key */
#define CONTROL         ControlMask /* Control key */
#define SHIFT           ShiftMask   /* Shift key */
#define ALT				Mod1Mask
#define SUP				Mod4Mask

/** generic settings **/
#define MASTER_SIZE     0.75
#define SHOW_PANEL      True      /* show panel by default on exec */
#define TOP_PANEL       True      /* False means panel is on bottom */
#define PANEL_HEIGHT    24        /* 0 for no space for panel, thus no panel */
#define DEFAULT_MODE    TILE      /* initial layout/mode: TILE MONOCLE BSTACK GRID FLOAT */
#define ATTACH_ASIDE    True      /* False means new window is master */
#define FOLLOW_WINDOW   False     /* follow the window when moved to a different desktop */
#define FOLLOW_MOUSE    False     /* focus the window the mouse just entered */
#define CLICK_TO_FOCUS  True      /* focus an unfocused window when clicked  */
#define FOCUS_BUTTON    Button1   /* mouse button to be used along with CLICK_TO_FOCUS */
#define BORDER_WIDTH    2         /* window border width */
#define FOCUS           "#6F6F6F" /* focused window border color 7D7D7D*/
#define UNFOCUS         "#575757" /* unfocused window border color 5f5f5f*/
#define MINWSZ          30        /* minimum window size in pixels  */
#define DEFAULT_DESKTOP 0         /* the desktop to focus initially */
#define DESKTOPS        10        /* number of desktops - edit DESKTOPCHANGE keys to suit */
#define USELESSGAP      0         /* the size of the useless gap in pixels */


/************************************************************************************************************************
*																												  		*
* open applications to specified desktop with specified mode. ----------===========----------===========----------======*
* if desktop is negative, then current is assumed ----------===========----------===========----------===========-------*
*																												  		*
************************************************************************************************************************/
static const AppRule rules[] = { \
  /*	class                   	desktop        follow          	float*/
  { 	"Firefox",                   1,            False,         	False },
  { 	"urxvt",	                -1,            False,         	False }
};

/* helper for spawning shell commands */
#define SHCMD(cmd) {.com = (const char*[]){"/usr/bin/sh", "-c", cmd, NULL}}
/***********************************************************************************************************************/




/************************************************************************************************************************
*																												  		*
* custom commands must always end with ', NULL };' ----------===========----------===========----------===========------*
*																												        *
************************************************************************************************************************/
static const char *terminal_emulator[]  = { "/usr/bin/urxvt",					NULL 						};
static const char *web_browser[]        = { "/usr/bin/firefox",					NULL						};
/***********************************************************************************************************************/




#define DESKTOPCHANGE(K,N) \
    {  MOD4,             K,              change_desktop, {.i = N}}, \
    {  MOD4|ControlMask, K,              client_to_desktop, {.i = N}},




/************************************************************************************************************************
*																													    *
* KEYBOARD SHORTCURS ----------===========----------===========----------===========----------===========----------=====*
*																												    	*
************************************************************************************************************************/
static Key keys[] = {
/********************************************** BASIC WINDOW MANIPULATION **********************************************/
    /* modifier       	key            function       	argument */
    {  SUP, 			XK_x,          killclient,     	{ NULL }},
    {  SUP,          	XK_Tab,        next_win,       	{ NULL }},
    {  SUP|SHIFT,       XK_Tab,        prev_win,        { NULL }},
    {  SUP,             XK_p,          last_desktop,    { NULL }},
    {  SUP|CONTROL, 	XK_r,          quit,           	{ .i = 0 }}, /* quit with exit value 0 */
    {  SUP|CONTROL,  	XK_q,          quit,           	{ .i = 1 }}, /* quit with exit value 1 */

    {  SUP, 			XK_k,          resize_master,  	{ .i = +15 }}, /* increase */
    {  SUP,  			XK_j,          resize_master,  	{ .i = -15 }}, /* decrease */
    {  SUP,             XK_L,          resize_stack,    { .i = +20 }},
    {  ALT|CONTROL,     XK_Left,       rotate,          { .i = +1 }},
    {  ALT,  			XK_Left,       rotate_filled,  	{ .i = -1 }},
    {  ALT,  			XK_Right,      rotate_filled,  	{ .i = +1 }},
    {  SUP,             XK_Return,     togglepanel,     { NULL }},
    {  ALT,             XK_Tab,        swap_master,     { NULL }},
    {  ALT,             XK_w,          focusurgent,     { NULL }},
/***********************************************************************************************************************/


/************************************************* CHANGE VIEWING MODE *************************************************/
    /* modifier       	key            function       	argument */
    {  SUP,  			XK_t,          switch_mode,    	{ .i = TILE }},
    {  SUP,  			XK_T,          switch_mode,    	{ .i = TILE }},
    {  SUP,  			XK_m,          switch_mode,    	{ .i = MONOCLE }},
    {  SUP,  			XK_M,          switch_mode,    	{ .i = MONOCLE }},
    {  SUP,  			XK_b,          switch_mode,    	{ .i = BSTACK }},
    {  SUP,  			XK_B,          switch_mode,    	{ .i = BSTACK }},
    {  SUP,  			XK_g,          switch_mode,    	{ .i = GRID }},
    {  SUP,  			XK_G,          switch_mode,    	{ .i = GRID }},
/***********************************************************************************************************************/


/************************************************* WINDOW DECORATION ***************************************************/
    /* modifier       	key            	function       	argument */
    {  SUP|CONTROL,		XK_Down,		moveresize,     { .v = (int []){   0,  25,   0,   0 }}}, /* move up    */
    {  SUP|CONTROL,		XK_Up,     		moveresize,     { .v = (int []){   0, -25,   0,   0 }}}, /* move down  */
    {  SUP|CONTROL,		XK_Right,   	moveresize,     { .v = (int []){  25,   0,   0,   0 }}}, /* move right */
    {  SUP|CONTROL,		XK_Left,    	moveresize,     { .v = (int []){ -25,   0,   0,   0 }}}, /* move left  */
    {  SUP|SHIFT,		XK_Down,    	moveresize,     { .v = (int []){   0,   0,   0,  25 }}}, /* height grow   */
    {  SUP|SHIFT,		XK_Up,      	moveresize,     { .v = (int []){   0,   0,   0, -25 }}}, /* height shrink */
    {  SUP|SHIFT,    	XK_Right,   	moveresize,     { .v = (int []){   0,   0,  25,   0 }}}, /* width grow    */
    {  SUP|SHIFT,   	XK_Left,    	moveresize,     { .v = (int []){   0,   0, -25,   0 }}}, /* width shrink  */
/***********************************************************************************************************************/


/*************************************************** APP LAUNCHING *****************************************************/
    /* modifier       	key            	function       	argument */
    {  SUP, 			XK_a,     		spawn,     		{ .com = terminal_emulator     }},
    {  SUP,  			XK_w,          	spawn,          { .com = web_browser           }},
    {  SUP,  			XK_Up,          spawn,          SHCMD("xbacklight -inc 20")  },
    {  SUP,  			XK_Down,        spawn,          SHCMD("xbacklight -dec 20")  },
    {  SUP,  			XK_Left,        spawn,          SHCMD("amixer -q sset Master 3%-")  },
    {  SUP,  			XK_Right,        spawn,         SHCMD("amixer -q sset Master 3%+")  },
/***********************************************************************************************************************/


/************************************************** DESKTOP SWITCH *****************************************************/
    DESKTOPCHANGE(     XK_1,                 0)
    DESKTOPCHANGE(     XK_2,                 1)
    DESKTOPCHANGE(     XK_3,                 2)
    DESKTOPCHANGE(     XK_4,                 3)
    DESKTOPCHANGE(     XK_5,                 4)
    DESKTOPCHANGE(     XK_6,                 5)
    DESKTOPCHANGE(     XK_7,                 6)
    DESKTOPCHANGE(     XK_8,                 7)
    DESKTOPCHANGE(     XK_9,                 8)
    DESKTOPCHANGE(     XK_0,                 9)
/***********************************************************************************************************************/
};

static Button buttons[] = {
    {  ALT,    Button1,     mousemotion,   {.i = MOVE}},
    {  ALT,    Button3,     mousemotion,   {.i = RESIZE}},
};
#endif
