using Toybox.WatchUi;

class DailyLoadDictConverter {

	function convertAll(results) {
        var statuses = [];
        for(var i = 0; i < results.size(); i++) {
            var result = results[i];
            statuses.add(convert(result));
        }

        return statuses;
	}

	function convert(result) {
		var day = getDay(result);
    	var year = getYear(result);
    	var restHr = getRestHr(result);
    	var sportsLoads = getSportsLoads(result);

		return {
            "day" => day,
            "year" => year,
            "restHr" => restHr,
            "sportsLoads" => sportsLoads
        };
	}

	function getDay(result) {
		return result["day"];
	}

	function getYear(result) {
		return result["year"];
	}

	function getRestHr(result) {
		var restHr = 0;
	    if (result["restingBpm"] != null) {
	        restHr = result["restingBpm"];
	    }

	    return restHr;
	}

	function getSportsLoads(result) {
		var converter = new DailySportLoadDictConverter();
		var sports = converter.convertAll(result["load"]);

		return sports;
	}
}

class DailySportLoadDictConverter {

	function convertAll(load) {
        var sportTypes = WatchUi.loadResource(Rez.JsonData.sportTypes);

		var sportsLoads = [];

        if (load == null) {
            return sportsLoads;
        }

        for(var i = 0; i < sportTypes.size(); i++) {
            var sport = sportTypes[i];

            var sportLoad = load[sport];
            if (sportLoad == null) {
                continue;
            }

            sportsLoads.add(convert(sport, sportLoad));
        }

        return sportsLoads;
	}

	function convert(sport, load) {
        var ctl = load["tscore"]["ctl"];
        var atl = load["tscore"]["atl"];
        var tscore = load["tscore"]["value"];

        return {
            "sport" => sport,
            "ctl" => ctl,
            "atl" => atl,
            "tscore" => tscore
        };
	}
}
