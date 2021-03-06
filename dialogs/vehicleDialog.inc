#define RSTF_VEHDG_IDD 1010

#define RSTF_VEHDG_LIST_IDC 5
#define RSTF_VEHDG_BUY_IDC 6
#define RSTF_VEHDG_CANCEL_IDC 7

#define RSTF_VEHDG_LIST_PADDING 0.01
#define RSTF_VEHDG_LIST_X (SafeZoneX + SafeZoneW / 2 - RSTF_VEHDG_LIST_W / 2)
#define RSTF_VEHDG_LIST_Y (-RSTF_VEHDG_LIST_PADDING)
#define RSTF_VEHDG_LIST_W (1.2 - RSTF_VEHDG_LIST_PADDING * 2)
#define RSTF_VEHDG_LIST_H (1 - RSTF_VEHDG_LIST_PADDING * 2)

#define RSTF_VEHDG_VEH_PADDING 0.01
#define RSTF_VEHDG_VEH_MARGIN 0.02

#define RSTF_VEHDG_VEH_W (RSTF_VEHDG_LIST_W / 2 - RSTF_VEHDG_VEH_MARGIN)
#define RSTF_VEHDG_VEH_H 0.25

#define RSTF_VEHDG_VEH_PIC_X RSTF_VEHDG_VEH_PADDING
#define RSTF_VEHDG_VEH_PIC_Y RSTF_VEHDG_VEH_PADDING
#define RSTF_VEHDG_VEH_PIC_W (RSTF_VEHDG_VEH_W * 0.4)
#define RSTF_VEHDG_VEH_PIC_H (RSTF_VEHDG_VEH_H - RSTF_VEHDG_VEH_PADDING * 2)

#define RSTF_VEHDG_VEH_TITLE_X (RSTF_VEHDG_VEH_PIC_X + RSTF_VEHDG_VEH_PIC_W + RSTF_VEHDG_VEH_PADDING)
#define RSTF_VEHDG_VEH_TITLE_Y RSTF_VEHDG_VEH_PADDING
#define RSTF_VEHDG_VEH_TITLE_W (RSTF_VEHDG_VEH_W - RSTF_VEHDG_VEH_TITLE_X - RSTF_VEHDG_VEH_PADDING)
#define RSTF_VEHDG_VEH_TITLE_H 0.035

#define RSTF_VEHDG_VEH_DESC_X (RSTF_VEHDG_VEH_PIC_X + RSTF_VEHDG_VEH_PIC_W + RSTF_VEHDG_VEH_PADDING)
#define RSTF_VEHDG_VEH_DESC_Y (RSTF_VEHDG_VEH_TITLE_Y + RSTF_VEHDG_VEH_TITLE_H + RSTF_VEHDG_VEH_PADDING)
#define RSTF_VEHDG_VEH_DESC_W (RSTF_VEHDG_VEH_W - RSTF_VEHDG_VEH_TITLE_X - RSTF_VEHDG_VEH_PADDING)
#define RSTF_VEHDG_VEH_DESC_H (RSTF_VEHDG_VEH_H - (RSTF_VEHDG_VEH_TITLE_Y + RSTF_VEHDG_VEH_TITLE_H) - RSTF_VEHDG_VEH_PRICE_H - RSTF_VEHDG_LIST_PADDING * 2)

#define RSTF_VEHDG_VEH_PRICE_X RSTF_VEHDG_VEH_TITLE_X
#define RSTF_VEHDG_VEH_PRICE_Y (RSTF_VEHDG_VEH_H - RSTF_VEHDG_VEH_PADDING - RSTF_VEHDG_VEH_PRICE_H)
#define RSTF_VEHDG_VEH_PRICE_W 0.1
#define RSTF_VEHDG_VEH_PRICE_H 0.05

#define RSTF_VEHDG_VEH_BUY_X (RSTF_VEHDG_VEH_W - RSTF_VEHDG_VEH_PADDING - RSTF_VEHDG_VEH_BUY_W)
#define RSTF_VEHDG_VEH_BUY_Y (RSTF_VEHDG_VEH_H - RSTF_VEHDG_VEH_PADDING - RSTF_VEHDG_VEH_BUY_H)
#define RSTF_VEHDG_VEH_BUY_W 0.1
#define RSTF_VEHDG_VEH_BUY_H 0.05

#define RSTF_VEHDG_CANCEL_X (RSTF_VEHDG_LIST_X - RSTF_VEHDG_LIST_PADDING)
#define RSTF_VEHDG_CANCEL_Y (RSTF_VEHDG_LIST_Y + RSTF_VEHDG_LIST_H + RSTF_VEHDG_LIST_PADDING * 2)
#define RSTF_VEHDG_CANCEL_W 0.10
#define RSTF_VEHDG_CANCEL_H 0.05