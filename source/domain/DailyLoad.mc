class DailyLoad {
	var _day = 0;
	var _year = 0;
	var _restHr = 0;
	var _sportsLoads = [];

	var _combinedCtl = 0;
	var _combinedAtl = 0;
	var _combinedTscore = 0;
	var _combinedTsb = 0;
	var _combinedTsbr = 0;

	function initialize(dict) {
		_day = dict["day"];
		_year = dict["year"];
		_restHr = dict["restHr"];

		if (dict["sportsLoads"] != null) {
			for(var i = 0; i < dict["sportsLoads"].size(); i++) {
				var sportLoadDict = dict["sportsLoads"][i];
				var sportLoad = new DailySportLoad(sportLoadDict);

	            _sportsLoads.add(sportLoad);
	        }
        }

        _combinedCtl = getCombinedCtl(_sportsLoads);
        _combinedAtl = getCombinedAtl(_sportsLoads);
        _combinedTscore = getCombinedTscore(_sportsLoads);
        _combinedTsb = getCombinedTsb(_sportsLoads);
        _combinedTsbr = getCombinedTsbr(_combinedCtl, _combinedAtl);
	}

	function empty() {
		return new DailyLoad({"day" => 0, "year" => 0, "restHr" => 0, "sportsLoads" => []});
	}


	function fromArray(array) {
		var dailyLoads = [];
        for(var i = 0; i < array.size(); i++) {
            var dailyLoad = new DailyLoad(array[i]);
            dailyLoads.add(dailyLoad);
        }

        return dailyLoads;
	}

	function getCombinedCtl(sportsLoads) {
        var sum = 0;
        for(var i = 0; i < sportsLoads.size(); i++) {
            sum = sum + sportsLoads[i]._ctl;
        }
        return sum;
    }

    function getCombinedAtl(sportsLoads) {
        var sum = 0;
        for(var i = 0; i < sportsLoads.size(); i++) {
            sum = sum + sportsLoads[i]._atl;
        }
        return sum;
    }

    function getCombinedTscore(sportsLoads) {
        var sum = 0;
        for(var i = 0; i < sportsLoads.size(); i++) {
            sum = sum + sportsLoads[i]._tscore;
        }
        return sum;
    }

    function getCombinedTsb(sportsLoads) {
        var sum = 0;
        for(var i = 0; i < sportsLoads.size(); i++) {
            sum = sum + sportsLoads[i]._tsb;
        }
        return sum;
    }

    function getCombinedTsbr(combinedCtl, combinedAtl) {
        if (combinedCtl > 0) {
            return ((combinedAtl / combinedCtl) * 100);
        }

        return 0;
    }
}

class DailySportLoad {
	var _sport = "";
    var _ctl = 0;
    var _atl = 0;
    var _tscore = 0;
    var _tsb = 0;
    var _tsbr = 0;

    function initialize(dict) {
        _sport = dict["sport"];
        _ctl = dict["ctl"];
        _atl = dict["atl"];
        _tscore = dict["tscore"];
        _tsb = (_ctl - _atl);

        if (_ctl != 0) {
            _tsbr = ((_atl / _ctl) * 100);
        }
    }
}
