<?php
require 'vendor/autoload.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

    // $to = $row['email'];
    $to = 'test@email.com.my';
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
    $mail->Subject = 'Test Email Scheduler';
    $mail->Body = 'This is a test email scheduler.';

    $mail->send();
    echo 'Email sent successfully!';
} catch (Exception $e) {
    echo 'Failed to send email. Error: ' . $mail->ErrorInfo;
}


?>
