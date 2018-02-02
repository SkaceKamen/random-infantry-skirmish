#define LOGPREFIXFILE (if (isNil('_fnc_scriptName')) then { __FILE__ } else { _fnc_scriptName })
#define LOGPREFIX(s) ('[RSTF] ' + s + ' (' + LOGPREFIXFILE + ':' + str(__LINE__ + 1) + ')')

#define DLOG(s) (diag_log(text(LOGPREFIX(s))))
#define DLOG_1(s, x1) (DLOG(FORMAT_1(s, x1)))
#define DLOG_2(s, x1, x2) (DLOG(FORMAT_2(s, x1, x2)))
#define DLOG_3(s, x1, x2, x3) (DLOG(FORMAT_3(s, x1, x2, x3)))
#define DLOG_4(s, x1, x2, x3, x4) (DLOG(FORMAT_4(s, x1, x2, x3)))

#define FORMAT_1(STR,ARG1) format[STR, ARG1]
#define FORMAT_2(STR,ARG1,ARG2) format[STR, ARG1, ARG2]
#define FORMAT_3(STR,ARG1,ARG2,ARG3) format[STR, ARG1, ARG2, ARG3]
#define FORMAT_4(STR,ARG1,ARG2,ARG3,ARG4) format[STR, ARG1, ARG2, ARG3, ARG4]
#define FORMAT_5(STR,ARG1,ARG2,ARG3,ARG4,ARG5) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5]
#define FORMAT_6(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6]
#define FORMAT_7(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7]
#define FORMAT_8(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8]
