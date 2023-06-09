<?php
require 'vendor/autoload.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// MSSQL database connection settings
$serverName = "192.168.75.85,1433";
$connectionOptions = array(
    "Database" => "mcmctssdb",
    "Uid" => "sa",
    "PWD" => "P@ssw0rd"
);

// Connect to MSSQL server
$conn = sqlsrv_connect($serverName, $connectionOptions);
if ($conn === false) {
    die(print_r(sqlsrv_errors(), true));
}

// Query to retrieve email addresses from the database
$sql = "SELECT email FROM admin_user WHERE email='fakhri@zen.com.my'";
$result = sqlsrv_query($conn, $sql);
if ($result === false) {
    die(print_r(sqlsrv_errors(), true));
}

// Loop through the results and send email to each address
while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    echo $to = $row['email'];
    $mail = new PHPMailer(true);

try {
    $mail->isSMTP();
    $mail->Host = 'smtp.ethereal.email';
    $mail->Port = 587;
    $mail->SMTPAuth = true;
    $mail->Username = 'meghan.cummerata@ethereal.email';
    $mail->Password = 'DC6EK3MeEeVV9ZNgdT';

    $mail->setFrom('scheduler@example.com', 'Scheduler');
    $mail->addAddress($to);
    $mail->Subject = 'Test Email';
    $mail->Body = 'This is a test email.';

    $mail->send();
    echo 'Email sent successfully!';
} catch (Exception $e) {
    echo 'Failed to send email. Error: ' . $mail->ErrorInfo;
}
}

// Close the database connection
sqlsrv_close($conn);
?>
