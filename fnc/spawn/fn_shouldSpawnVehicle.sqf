params ['_group', '_side'];

count(units(_group)) > 1 &&
_side != SIDE_NEUTRAL &&
RSTF_MONEY_ENABLED &&
RSTF_MONEY_VEHICLES_ENABLED &&
count(RSTF_AI_VEHICLES select _side) < RSTF_MONEY_VEHICLES_AI_LIMIT