<?php
// without docker-compose   
// $host = "my-mysql-2"; 
// $db_name = "test_db"; 
// $username = "may";
// $password = getenv('MYSQL_PASSWORD');

// For docker-compose   
$host = getenv('DB_HOST');
$db_name = getenv('MYSQL_DATABASE');
$username = getenv('MYSQL_USER');
$password = getenv('MYSQL_PASSWORD');

try {
    $connection = new PDO("mysql:host=" . $host . ";dbname=" . $db_name, $username, $password);
    $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
    $connection->exec("set names utf8");
} catch(Exception $exception) {
    die("Connection error: " . $exception->getMessage()); // Use die() to stop execution on connection error
}

function emailExists($email) {
    global $connection;
    $query = "SELECT COUNT(*) as count FROM users WHERE email = :email";
    $stmt = $connection->prepare($query);
    $stmt->bindParam(":email", $email);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result['count'] > 0;
}

function saveData($name, $email, $message){
    global $connection;

    if(emailExists($email)) {
        return '<h3 style="text-align:center;">Error: Email already exists!</h3>';
    }

    $query = "INSERT INTO users(name, email, message) VALUES(:name, :email, :message)";
    $stmt = $connection->prepare($query);

    $name = htmlspecialchars(strip_tags($name));
    $email = htmlspecialchars(strip_tags($email));
    $message = htmlspecialchars(strip_tags($message));
    
    $stmt->bindParam(":name", $name);
    $stmt->bindParam(":email", $email);
    $stmt->bindParam(":message", $message);

    if($stmt->execute()) {
        return '<h3 style="text-align:center;">Saved to DB!</h3>';
    } else {
        return '<h3 style="text-align:center;">Failed to save to DB!</h3>';
    }
}

if(isset($_POST['submit'])) {
    $name = htmlentities($_POST['name']);
    $email = htmlentities($_POST['email']);
    $message = htmlentities($_POST['message']);
    $result = saveData($name, $email, $message);
    echo $result;
} else {
    echo '<h3 style="text-align:center;">A very detailed error message ( ͡° ͜ʖ ͡°)</h3>';
}
?>



