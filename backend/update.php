<?

$hn = file_get_contents('https://news.ycombinator.com');

preg_match_all("/<tr>\s*<td[\s\w\"'=]*>\d+\.\s*<\/td>\s*<td>\s*<center>.*?<\/center>\s*<\/td>\s*<td[\s\w\"'=]*><a[?\s\w\"'=]*href=\"([^\"]*)\"[\s\w\"'=]*>([^<]*)<\/a>\s*(?:<span[\s\w\"'=]*>[^<]*<\/span>)?\s*<\/td>\s*<\/tr>\s*<tr>\s*<td[\s\w\"'=]*>\s*<\/td>\s*<td[\s\w\"'=]*>\s*<span[\s\w\"'=]*>\s*(\d+)[a-zA-Z\s]*<\/span>\s*by\s*<a[?\s\w\"'=]*>\w*<\/a>\s*(\d*)\s*[|a-zA-Z\s\d]*<a[?\s\w\"'=]*href=\"item\?id=(\d*)\"[\s\w\"'=]*>[\s\w]*<\/a>/", $hn, $out, PREG_PATTERN_ORDER);

$length = min([count($out[1]), count($out[2]), count($out[3]), count($out[4])]);
$data = [];

for ($i = 0; $i < $length; $i++) {
	$data[] = [
		'url' => $out[1][$i],
		'title' => $out[2][$i],
		'points' => intval($out[3][$i]),
		'time' => strtotime(date('Y-m-d H:i:s') . ' -'.intval($out[4][$i]).' hour'),
		'id' => $out[5][$i]
	];
}

file_put_contents('front_page.json', json_encode($data));

?>