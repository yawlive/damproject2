<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
include 'connect.php';
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    include 'connect.php';
    $restaurantId = $_POST['RestaurantId'];


    if (!empty($restaurantId)) {
        $query = "DELETE FROM Restaurants WHERE RestaurantId = ?";
        $stmt = $con->prepare($query);
        $stmt->bind_param("i", $restaurantId);

        if ($stmt->execute()) {
            echo json_encode(["status" => "success"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Failed to delete"]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "No id provided"]);
    }
}
?>
