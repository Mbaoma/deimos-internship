<?php
// without docker-compose   
$host = "my-mysql-2"; 
$db_name = "test_db"; 
$username = "root";
$password = getenv('MYSQL_ROOT_PASSWORD');

// for docker-compose   
// $host = getenv('DB_HOST');
// $db_name = getenv('MYSQL_DATABASE');
// $username = getenv('USER');
// $password = getenv('MYSQL_ROOT_PASSWORD');

try{
$connection = new PDO("mysql:host=" . $host . ";dbname=" . $db_name, $username, $password);
$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); #enabled error reporting via PDOexceptions
$connection->exec("set names utf8");
}catch(Exception $exception){
echo "Connection error: " . $exception->getMessage();
}

function saveData($name, $email, $message){
global $connection;
$query = "INSERT INTO users(name, email, message) VALUES( :name, :email, :message)";

$callToDb = $connection->prepare( $query );
$name=htmlspecialchars(strip_tags($name));
$email=htmlspecialchars(strip_tags($email));
$message=htmlspecialchars(strip_tags($message));
$callToDb->bindParam(":name",$name);
$callToDb->bindParam(":email",$email);
$callToDb->bindParam(":message",$message);

if($callToDb->execute()){
return '<h3 style="text-align:center;">Saved to DB!</h3>';
}
}

if( isset($_POST['submit'])){
$name = htmlentities($_POST['name']);
$email = htmlentities($_POST['email']);
$message = htmlentities($_POST['message']);

// then you can use them in a PHP function. 
$result = saveData($name, $email, $message);
echo $result;
}
else{
echo '<h3 style="text-align:center;">A very detailed error message ( ͡° ͜ʖ ͡°)</h3>';
}
?>


