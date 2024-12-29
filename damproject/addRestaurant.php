<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");
include("connect.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Get the data sent from the Flutter app
    $restaurantName = $_POST['RestaurantName'];
    $phone = $_POST['Phone'];
    $description = $_POST['Description'];
    $imageURL = $_POST['ImageURL'];
    $regionName = $_POST['RegionName'];
    $categoryName = $_POST['CategoryName'];

    // Insert the new restaurant into the database
    $sql = "INSERT INTO Restaurants (RestaurantName, Phone, Description, ImageURL, RegionName, CategoryName) 
            VALUES ('$restaurantName', '$phone', '$description', '$imageURL', '$regionName', '$categoryName')";

    if ($con->query($sql) === TRUE) {
        echo json_encode(["message" => "Restaurant added successfully"]);
    } else {
        echo json_encode(["message" => "Error: " . $con->error]);
    }
}
?>

