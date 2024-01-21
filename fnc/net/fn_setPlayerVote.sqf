private _owner = remoteExecutedOwner;
private _voteIndex = param [0];

if (_owner in RSTF_VOTES_SUBMITTED) exitWith { false; };

RSTF_POINT_VOTES set [_voteIndex, (RSTF_POINT_VOTES select _voteIndex) + 1];
RSTF_VOTES_SUBMITTED pushBack _owner;

publicVariable "RSTF_POINT_VOTES";
