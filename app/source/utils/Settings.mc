(:background)
class Settings {
	const CLIENT_ID = "todaysload";
    const CLIENT_SECRET = "98388789-38c1-11e9-8dae-0a6d5206ef75";
    const HOSTNAME = "https://whats.todaysplan.com.au/";
    const SPORT_TYPES = ["ride", "swim", "gym", "walk", "run"];
	const BACKGROUND_PERIOD_DURATION = new Time.Duration(30 * 60);
    const FIELDS_MAP = {
		"0" => null,
		"1" => "ctl",
		"2" => "atl",
		"3" => "tscore",
		"4" => "tsb",
		"5" => "tsbr",
		"6" => "restHr",
		"7" => "date"
	};
	const FIELDS_TITLES = {
		"ctl" => "CTL",
		"atl" => "ATL",
		"tscore" => "TScore",
		"tsb" => "TSB",
		"tsbr" => "TSB(r)",
		"restHr" => "RHR",
		"date" => "Date"
	};
	const DAILY_LOADS_STORAGE_KEY = "dailyLoads";
}
