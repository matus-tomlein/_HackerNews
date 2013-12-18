<?

require 'Readability.inc.php';
require 'Encoding.php';

$url = $_GET['url'];
$html = Encoding::toUTF8(file_get_contents($url));
$Readability = new Readability($html, 'utf-8'); // default charset is utf-8
$ReadabilityData = $Readability->getContent(); // throws an exception when no suitable content is found

?>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<base href="<?= $url ?>">
	<title><?= $ReadabilityData['title'] ?></title>
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" type="text/css">
	<style type="text/css" media="screen">
	#container {
		padding: 5px;
	}
	</style>
</head>
<body>
	<div id="container">
		<h1><?= $ReadabilityData['title'] ?></h1>
		<div id="content">
			<?= $ReadabilityData['content'] ?>
		</div>
	</div>
</body>
</html>